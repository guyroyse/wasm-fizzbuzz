(module

  (export "onButtonClicked" (func $onButtonClicked))

  (import "fizzbuzzModel" "fizzbuzz" (func $fizzbuzz (param i32) (result i32)))
  (import "fizzbuzzView" "getInput" (func $getInput (result i32)))
  (import "fizzbuzzView" "setResult" (func $setResult (param i32)))

  (func $onButtonClicked
    call $getInput
    call $fizzbuzz
    call $setResult
  )
)
