(module

  (import "strings" "itoa" (func $itoa (param i32) (param i32)))

  (import "passiveView" "getInput" (func $getHtmlInput (result i32)))
  (import "passiveView" "setResult" (func $setHtmlResult (param i32)))

  (import "js" "memory" (memory 1))

  (export "getInput" (func $getInput))
  (export "setResult" (func $setResult))

  (data (i32.const 0) "\04fizz")
  (data (i32.const 5) "\04buzz")
  (data (i32.const 10) "\08fizzbuzz")

  (func $getInput (result i32)
    call $getHtmlInput
  )

  (func $setResult (param $result i32)
    (if (i32.eq (get_local $result) (i32.const -1)) (then
      (call $setToFizz)
    )
    (else
      (if (i32.eq (get_local $result) (i32.const -2)) (then
        (call $setToBuzz))
      (else
        (if (i32.eq (get_local $result) (i32.const -3)) (then
          (call $setToFizzBuzz))
        (else
          (call $setToNumber (get_local $result))
        ))
      ))
    ))
  )

  (func $setToFizz
    (call $setHtmlResult (i32.const 0))
  )

  (func $setToBuzz
    (call $setHtmlResult (i32.const 5))
  )

  (func $setToFizzBuzz
    (call $setHtmlResult (i32.const 10))
  )

  (func $setToNumber (param $n i32)
    (call $itoa (get_local $n) (i32.const 19))
    (call $setHtmlResult (i32.const 19))
  )
)