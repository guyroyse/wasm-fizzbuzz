describe("view.wasm", function() {

  let subject, memory, mockPassiveView

  beforeEach(function(done) {
    memory = new WebAssembly.Memory({ initial: 1 })
    mockPassiveView = jasmine.createSpyObj('passiveView', ['getInput', 'setResult'])

    loadWasm('/math.wasm')
      .then(math => loadWasm('/strings.wasm', { js: { memory }, math }))
      .then(strings => loadWasm('/view.wasm', {
          passiveView: mockPassiveView,
          js: { memory },
          strings
        }))
      .then(view => subject = view)
      .then(done)

  })

  describe("#getInput", function() {

    let result

    beforeEach(function() {
      mockPassiveView.getInput.and.returnValue(666)
      result = subject.getInput()
    })

    it("gets the input from the passive view", function() {
      expect(mockPassiveView.getInput).toHaveBeenCalled()
    })

    it("returns the value from the passive view", function() {
      expect(result).toBe(666)
    })
  })

  describe("#setResult", function() {
    it("sets the number in the results", function() {
      subject.setResult(1)
      expect(getStringFromCall()).toBe('1')
    })

    it("sets fizz as a result for -1", function() {
      subject.setResult(-1)
      expect(getStringFromCall()).toBe('fizz')
    })

    it("sets buzz as a result for -2", function() {
      subject.setResult(-2)
      expect(getStringFromCall()).toBe('buzz')
    })

    it("sets buzz as a result for -3", function() {
      subject.setResult(-3)
      expect(getStringFromCall()).toBe('fizzbuzz')
    })

    function getStringFromCall() {
      let stringToDecode = mockPassiveView.setResult.calls.first().args[0]
      return decodeString(memory, stringToDecode)
    }
  })

})