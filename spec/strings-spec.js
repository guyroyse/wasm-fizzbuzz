describe("strings.wasm", function() {

  let subject

  beforeEach(function(done) {
    loadWasm('/math.wasm')
      .then(math => loadWasm('/strings.wasm', { math }))
      .then(strings => subject = strings)
      .then(done)
  })

  describe("#itoa", function() {
    it("converts 0", function() {
      subject.itoa(0)
      expect(decodeString(subject.memory)).toBe('0')
    })

    it("converts single digits", function() {
      subject.itoa(5)
      expect(decodeString(subject.memory)).toBe('5')
    })

    it("converts double digits", function() {
      subject.itoa(42)
      console.log(new Uint8Array(subject.memory.buffer))
      expect(decodeString(subject.memory)).toBe('42')
    })

    it("converts multiple digits", function() {
      subject.itoa(666)
      console.log(new Uint8Array(subject.memory.buffer))
      expect(decodeString(subject.memory)).toBe('666')
    })
  })

})