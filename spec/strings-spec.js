describe("strings.wasm", function() {

  let subject, memory

  beforeEach(function(done) {
    memory = new WebAssembly.Memory({ initial: 1 })

    loadWasm('/math.wasm')
      .then(math => loadWasm('/strings.wasm', { math, js: { memory } }))
      .then(strings => subject = strings)
      .then(done)
  })

  describe("#itoa", function() {
    it("converts 0", function() {
      subject.itoa(0, 0)
      expect(decodeString(memory)).toBe('0')
    })

    it("converts single digits", function() {
      subject.itoa(5, 0)
      expect(decodeString(memory)).toBe('5')
    })

    it("converts double digits", function() {
      subject.itoa(42, 0)
      expect(decodeString(memory)).toBe('42')
    })

    it("converts multiple digits", function() {
      subject.itoa(666, 0)
      expect(decodeString(memory)).toBe('666')
    })

    it("stores numbers add non-zero address", function() {
      subject.itoa(666, 100)
      expect(decodeString(memory, 100)).toBe('666')
    })
  })

})