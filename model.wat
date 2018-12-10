(module

  (export "fizzbuzz" (func $fizzbuzz))

  (func $fizzbuzz (param $n i32) (result i32)

    (if (call $is_multiple_of (get_local $n) (i32.const 15))
      (then (return (i32.const -3)))
    )

    (if (call $is_multiple_of (get_local $n) (i32.const 5))
      (then (return (i32.const -2)))
    )

    (if (call $is_multiple_of (get_local $n) (i32.const 3))
      (then (return (i32.const -1)))
    )

    (return (get_local $n))
  )

  (func $is_multiple_of (param $number i32) (param $divisor i32) (result i32)
    (i32.eqz (i32.rem_u (get_local $number) (get_local $divisor)))
  )

)
