function loadWasm(path, imports) {
  return fetch(path)
    .then(response => response.arrayBuffer())
    .then(bytes => WebAssembly.instantiate(bytes, imports))
    .then(results => results.instance.exports)
}
