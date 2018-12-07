(module

  (export "onButtonClicked" (func $onButtonClicked))

  (import "model" "fizzbuzz" (func $fizzbuzz (param i32) (result i32)))
  (import "view" "getInput" (func $getInput (result i32)))
  (import "view" "setResult" (func $setResult (param i32)))

  (func $onButtonClicked
    (call $setResult (call $fizzbuzz (call $getInput)))
  )
)
