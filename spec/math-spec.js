describe("math.wasm", function() {

  let subject

  beforeEach(function(done) {
    loadWasm('/math.wasm')
      .then(math => subject = math)
      .then(done)
  })

  describe("#increment", function() {
    it("increments a number", function() {
      expect(subject.increment(1)).toBe(2)
    })

    it("increments other numbers", function() {
      expect(subject.increment(2)).toBe(3)
    })

    it("increments 0", function() {
      expect(subject.increment(0)).toBe(1)
    })

    it("increments negative numbers", function() {
      expect(subject.increment(-2)).toBe(-1)
    })
  })

  describe("#decrement", function() {
    it("decrements a number", function() {
      expect(subject.decrement(1)).toBe(0)
    })

    it("decrements other numbers", function() {
      expect(subject.decrement(2)).toBe(1)
    })

    it("decrements 0", function() {
      expect(subject.decrement(0)).toBe(-1)
    })

    it("decrements negative numbers", function() {
      expect(subject.decrement(-2)).toBe(-3)
    })
  })

  describe("#power", function() {
    it("computers power", function() {
      expect(subject.power(2, 4)).toBe(16)
    })

    it("computers other powers", function() {
      expect(subject.power(2, 2)).toBe(4)
    })

    it("computers zero powers", function() {
      expect(subject.power(2, 0)).toBe(1)
    })
  })

  describe("#countDigits", function() {
    it("counts single digits", function() {
      expect(subject.countDigits(5)).toBe(1)
    })

    it("counts double digits", function() {
      expect(subject.countDigits(42)).toBe(2)
    })

    it("counts multiple digits", function() {
      expect(subject.countDigits(666)).toBe(3)
    })

    it("counts 0 as having 1 digit", function() {
      expect(subject.countDigits(0)).toBe(1)
    })
  })

})