describe("model.wasm", function() {

  let subject

  beforeEach(function(done) {
    loadWasm('/model.wasm')
      .then(model => subject = model)
      .then(done)
  })

  describe("#fizzbuzz", function() {
    it("returns passed in number", function() {
      expect(subject.fizzbuzz(1)).toBe(1)
    })

    it("returns other passed in numbers", function() {
      expect(subject.fizzbuzz(2)).toBe(2)
    })

    it("returns -1 for multiples of 3", function() {
      expect(subject.fizzbuzz(3)).toBe(-1)
    })

    it("returns -1 for other multiples of 3", function() {
      expect(subject.fizzbuzz(6)).toBe(-1)
    })

    it("returns -2 for multiples of 5", function() {
      expect(subject.fizzbuzz(5)).toBe(-2)
    })

    it("returns -2 for other multiples of 5", function() {
      expect(subject.fizzbuzz(10)).toBe(-2)
    })

    it("returns -3 for multiples of 3 and 5", function() {
      expect(subject.fizzbuzz(15)).toBe(-3)
    })

    it("returns -3 for other multiples of 3 and 5", function() {
      expect(subject.fizzbuzz(30)).toBe(-3)
    })
  })

})