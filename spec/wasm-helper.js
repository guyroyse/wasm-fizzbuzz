function loadWasm(path, imports) {
  return fetch(path)
    .then(response => response.arrayBuffer())
    .then(bytes => WebAssembly.instantiate(bytes, imports))
    .then(results => results.instance.exports)
}

function decodeString(memory, offset = 0) {
  let startingBytes = new Uint8Array(memory.buffer, offset)
  let length = startingBytes[0]
  let bytes = startingBytes.slice(1, length + 1)
  var string = new TextDecoder('utf8').decode(bytes);
  return string
}