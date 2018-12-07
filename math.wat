(module

  (export "increment" (func $increment))
  (export "decrement" (func $decrement))
  (export "power" (func $power))
  (export "countDigits" (func $countDigits))

  (func $increment (param $n i32) (result i32)
    (i32.add (get_local $n) (i32.const 1))
  )

  (func $decrement (param $n i32) (result i32)
    (i32.sub (get_local $n) (i32.const 1))
  )

  (func $power (param $base i32) (param $exponent i32) (result i32)
    (local $counter i32)
    (local $accum i32)


    (if (i32.eqz (get_local $exponent))
      (then
        (return (i32.const 1))
      )
    )

    (set_local $counter (i32.const 1))
    (set_local $accum (get_local $base))

    (block
      (loop
        (br_if 1 (i32.ge_u (get_local $counter) (get_local $exponent)))
        (set_local $accum (i32.mul (get_local $base) (get_local $accum)))
        (set_local $counter (call $increment (get_local $counter)))
        (br 0)
      )
    )

    get_local $accum
  )

  (func $countDigits (param $n i32) (result i32)
    (local $length i32)
    (local $divisor i32)

    (set_local $length (i32.const 0))
    (set_local $divisor (i32.const 1))

    (if (i32.eqz (get_local $n))
      (then
        (return (i32.const 1))
      )
    )

    (block
      (loop
        (br_if 1 (i32.eqz (i32.div_u (get_local $n) (get_local $divisor))))
        (set_local $length (call $increment (get_local $length)))
        (set_local $divisor (i32.mul (get_local $divisor) (i32.const 10)))
        (br 0)
      )
    )

    (get_local $length)
  )

)