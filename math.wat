(module

  (export "increment" (func $increment))
  (export "decrement" (func $decrement))
  (export "power" (func $power))
  (export "countDigits" (func $countDigits))

  (func $increment (param $n i32) (result i32)
    get_local $n
    i32.const 1
    i32.add
  )

  (func $decrement (param $n i32) (result i32)
    get_local $n
    i32.const 1
    i32.sub
  )

  (func $power (param $base i32) (param $exponent i32)
    (local $counter i32)
    (local $accum i32)

    i32.const 1
    set_local $counter

    get_local $base
    set_local $accum

    loop

      get_local $counter
      get_local $exponent
      i32.lt_u
      if

        get_local $base
        get_local $accum
        i32.mul
        set_local $accum

        get_local $counter
        call $increment
        set_local $counter
        br 0

      else
        br 1 ;; we're done
      end
    end

    get_local $accum
  )

  (func $countDigits (param $n i32) (result i32)
    (local $length i32)
    (local $divisor i32)

    i32.const 0
    set_local $length

    i32.const 1
    set_local $divisor

    loop
      get_local $n
      get_local $divisor
      i32.div_u

      i32.eqz
      if
        br 1 ;; we're done
      else
        ;; add to length
        get_local $length
        call $increment
        set_local $length

        ;; mutliply divisor
        get_local $divisor
        i32.const 10
        i32.mul
        set_local $divisor

        ;; loop again
        br 0
      end
    end

    get_local $length
  )

)