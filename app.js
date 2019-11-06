document.addEventListener('DOMContentLoaded', async () => {

  let memory = new WebAssembly.Memory({ initial: 1 })

  let passiveView = (() => {

    let valueInput = document.querySelector('#value')
    let resultText = document.querySelector('#result')

    function getInput() {
      return Number(valueInput.value)
    }

    function setResult(result) {
      resultText.value = decodeString(memory, result)
    }

    return { getInput, setResult }

  })()

  let math = await loadWasm('math.wasm')
  let strings = await loadWasm('strings.wasm', { js: { memory }, math })
  let model = await loadWasm('model.wasm')
  let view = await loadWasm('view.wasm', { js: { memory }, passiveView, strings })
  let controller = await loadWasm('controller.wasm', { model, view })

  let fizzBuzzButton = document.querySelector('#fizzbuzz')
  fizzBuzzButton.addEventListener('click', () => controller.onButtonClicked())

})

async function loadWasm(path, imports) {
  let response = await fetch(path)
  let bytes = await response.arrayBuffer()
  let module = await WebAssembly.instantiate(bytes, imports)
  return module.instance.exports
}

function decodeString(memory, offset) {
  let startingBytes = new Uint8Array(memory.buffer, offset)
  let length = startingBytes[0]
  let bytes = startingBytes.slice(1, length + 1)
  var string = new TextDecoder('utf8').decode(bytes);
  return string
}
