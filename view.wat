(module

  (import "strings" "itoa" (func $itoa (param i32) (param i32)))

  (import "passiveView" "getInput" (func $getHtmlInput (result i32)))
  (import "passiveView" "setResult" (func $setHtmlResult (param i32)))

  (import "js" "memory" (memory 1))

  (export "getInput" (func $getInput))
  (export "setResult" (func $setResult))

  ;; these are to be prefixed with the length of the string
  (data (i32.const 1) "fizz")
  (data (i32.const 6) "buzz")
  (data (i32.const 11) "fizzbuzz")

  (start $init)

  (func $init
    ;; stores length of fizz
    i32.const 0
    i32.const 4
    i32.store8

    ;; stores length of buzz
    i32.const 5
    i32.const 4
    i32.store8

    ;; stores length of fizzbuzz
    i32.const 10
    i32.const 8
    i32.store8
  )

  (func $getInput (result i32)
    call $getHtmlInput
  )

  (func $setResult (param $result i32)
    get_local $result
    i32.const -1
    i32.eq
    if
      call $setToFizz
    else
      get_local $result
      i32.const -2
      i32.eq
      if
        call $setToBuzz
      else
        get_local $result
        i32.const -3
        i32.eq
        if
          call $setToFizzBuzz
        else
          get_local $result
          call $setToNumber
        end
      end
    end
  )

  (func $setToFizz
    i32.const 0
    call $setHtmlResult
  )

  (func $setToBuzz
    i32.const 5
    call $setHtmlResult
  )

  (func $setToFizzBuzz
    i32.const 10
    call $setHtmlResult
  )

  (func $setToNumber (param $n i32)
    get_local $n
    i32.const 19
    call $itoa

    i32.const 19
    call $setHtmlResult
  )
)