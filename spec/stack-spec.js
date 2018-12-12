describe("stack.wasm", function() {

  let subject, memory

  beforeEach(function(done) {
    memory = new WebAssembly.Memory({ initial: 1 })
    loadWasm('/stack.wasm', { js: { memory }})
      .then(stack => subject = stack)
      .then(done)
  })

  when("an item is pushed to the stack", function() {
    beforeEach(function() {
      subject.push(42)
    })

    it("has a size of 1", function() {
      expect(subject.size()).toBe(1)
    })

    it("has expected value on top", function() {
      expect(dereferenceInt32(subject.peek())).toBe(42)
    })

    when("another item is pushed to the stack", function() {
      beforeEach(function() {
        subject.push(666)
      })

      it("has a size of 2", function() {
        expect(subject.size()).toBe(2)
      })

      it("has expected value on top", function() {
        expect(dereferenceInt32(subject.peek())).toBe(666)
      })

      and("it is popped", function() {
        beforeEach(function() {
          this.result = subject.pop()
        })

        it("returns a pointer to the popped value", function() {
          expect(dereferenceInt32(this.result)).toBe(666)
        })

        it("has a size of 1", function() {
          expect(subject.size()).toBe(1)
        })

        it("has expected value on top", function() {
          expect(dereferenceInt32(subject.peek())).toBe(42)
        })

        and("it is popped again", function() {
          beforeEach(function() {
            this.result = subject.pop()
          })

          it("returns a pointer to the popped value", function() {
            expect(dereferenceInt32(this.result)).toBe(42)
          })

          it("has a size of 0", function() {
            expect(subject.size()).toBe(0)
          })

          it("has undefined value on top", function() {
            expect(dereferenceInt32(subject.peek())).not.toBeDefined()
          })

          and("it is popped a third time", function() {
            beforeEach(function() {
              this.result = subject.pop()
            })

            it("returns undefined", function() {
              expect(dereferenceInt32(this.result)).not.toBeDefined()
            })

            it("still has a size of 0", function() {
              expect(subject.size()).toBe(0)
            })

            it("still has undefined value on top", function() {
              expect(dereferenceInt32(subject.peek())).not.toBeDefined()
            })
          })
        })
      })
    })
  })

  function dereferenceInt32(pointer) {
    let array = new Int32Array(memory.buffer)
    console.log(array, pointer, array[pointer])
    return array[pointer]
  }

})