async function loadWasm(path, imports) {
  let response = await fetch(path)
  let bytes = await response.arrayBuffer()
  let module = await WebAssembly.instantiate(bytes, imports)
  return module.instance.exports
}

function decodeString(memory, psz) {
  let decoder = new TextDecoder('utf8')
  let shared = new Uint8Array(memory.buffer, psz)
  let index = shared.indexOf(0)

  let bytes = shared
  if(index !== -1) bytes = shared.slice(0, index)
  
  return decoder.decode(bytes)
}
