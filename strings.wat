(module

  (import "math" "decrement" (func $decrement (param i32) (result i32)))
  (import "math" "power" (func $power (param i32) (param i32) (result i32)))
  (import "math" "countDigits" (func $countDigits (param i32) (result i32)))

  (import "js" "memory" (memory 1))

  (export "itoa" (func $itoa))

  (func $itoa (param $number i32) (param $address i32)
    (local $length i32)
    (local $currentNumber i32)
    (local $currentOffset i32)
    (local $currentDigit i32)

    (if (i32.eqz (get_local $number))
      (then
        (call $storeDigit (i32.const 0) (i32.const 0) (get_local $address))
        (call $storeNull (i32.const 1) (get_local $address))
        (return)
      )
    )

    (set_local $length (call $countDigits (get_local $number)))
    (set_local $currentNumber (get_local $number))
    (set_local $currentOffset (get_local $length))

    (block
      (loop
        (set_local $currentOffset (call $decrement (get_local $currentOffset)))
        (set_local $currentDigit (i32.rem_u (get_local $currentNumber) (i32.const 10)))
        (set_local $currentNumber
          (i32.div_u
            (i32.sub
              (get_local $currentNumber)
              (get_local $currentDigit)
            )
            (i32.const 10)
          )
        )

        (call $storeDigit (get_local $currentDigit) (get_local $currentOffset) (get_local $address))

        (br_if 1 (i32.eqz (get_local $currentOffset)))
        (br 0)
      )
    )

    (call $storeNull (get_local $length) (get_local $address))

  )

  (func $storeDigit (param $digit i32) (param $position i32) (param $address i32)
    (call $storeValue 
      (call $digitToUtf8 (get_local $digit))
      (get_local $position)
      (get_local $address)
    )
  )

  (func $storeNull (param $position i32) (param $address i32)
    (call $storeValue 
      (i32.const 0)
      (get_local $position)
      (get_local $address)
    )
  )

  (func $storeValue (param $value i32) (param $position i32) (param $address i32)
    (i32.store8
      (i32.add (get_local $address) (get_local $position))
      (get_local $value)
    )
  )

  (func $digitToUtf8 (param $digit i32) (result i32)
    (i32.add (get_local $digit) (i32.const 48))
  )

)