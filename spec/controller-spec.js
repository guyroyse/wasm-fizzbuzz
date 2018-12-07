describe("controller.wasm", function() {

  let subject, mockView, mockModel

  beforeEach(function(done) {

    mockView = jasmine.createSpyObj('view', ['getInput', 'setResult'])
    mockModel = jasmine.createSpyObj('model', ['fizzbuzz'])

    loadWasm('/controller.wasm', {model: mockModel, view: mockView})
      .then(controller => subject = controller)
      .then(done)
  })

  describe("#onButtonClicked", function() {

    beforeEach(function() {
      mockView.getInput.and.returnValue(666)
      mockModel.fizzbuzz.and.returnValue(333)
      subject.onButtonClicked()
    })

    it("gets the input from the view", function() {
      expect(mockView.getInput).toHaveBeenCalled()
    })

    it("calls into the model with the value", function() {
      expect(mockModel.fizzbuzz).toHaveBeenCalledWith(666)
    })

    it("puts the result of the model into the view", function() {
      expect(mockView.setResult).toHaveBeenCalledWith(333)
    })
  })

})