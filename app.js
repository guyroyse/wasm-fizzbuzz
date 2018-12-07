document.addEventListener('DOMContentLoaded', () => {

  let memory = new WebAssembly.Memory({ initial: 1 })

  let passiveView = (() => {

    let valueInput = document.getElementById('value')
    let resultText = document.getElementById('result')

    function getInput() {
      return Number(valueInput.value)
    }

    function setResult(result) {
      resultText.value = decodeString(memory, result)
    }

    return { getInput, setResult, memory }

  })()

  loadWasm('/math.wasm')
    .then(math => loadWasm('/strings.wasm', { js: { memory }, math }))
    .then(strings =>
      Promise.all([
        loadWasm('model.wasm'),
        loadWasm('view.wasm', {
          html: passiveView,
          js: { memory },
          strings
        })
      ]))
    .then(modelAndView =>
      loadWasm('controller.wasm', {
        fizzbuzzModel: modelAndView[0],
        fizzbuzzView: modelAndView[1]
      }))
    .then(controller => {
      let fizzBuzzButton = document.getElementById('fizzbuzz')
      fizzBuzzButton.addEventListener('click', () => controller.onButtonClicked())
    })

})

function loadWasm(path, imports) {
  return fetch(path)
    .then(response => response.arrayBuffer())
    .then(bytes => WebAssembly.instantiate(bytes, imports))
    .then(results => {
      return results.instance.exports
    })
}

function decodeString(memory, offset) {
  let startingBytes = new Uint8Array(memory.buffer, offset)
  let length = startingBytes[0]
  let bytes = startingBytes.slice(1, length + 1)
  var string = new TextDecoder('utf8').decode(bytes);
  return string
}