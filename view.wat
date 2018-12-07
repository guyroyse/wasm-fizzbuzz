(module

  (import "html" "getInput" (func $getHtmlInput (result i32)))
  (import "html" "setResult" (func $setHtmlResult (param i32)))
  (import "html" "memory" (memory 1))

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
    call $itoa
    call $setHtmlResult
  )

  (func $itoa (param $n i32) (result i32)
    (local $length i32)
    (local $divisor i32)
    (local $currentDigit i32)
    (local $currentDivisor i32)

    get_local $n
    i32.eqz
    if ;; 0 is hard-coded
      i32.const 1
      call $storeLength

      i32.const 0
      i32.const 0
      call $storeDigit
    else

      get_local $n
      call $countDigits
      set_local $length

      ;; 1 = 1, 2 = 10, 3 = 100, etc.

      i32.const 10
      get_local $length
      call $power
      set_local $divisor

      loop
      end

      get_local $length
      call $storeLength

    end
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
        i32.const 1
        i32.add
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

  (func $storeLength (param $length i32)
      i32.const 19
      get_local $length
      i32.store8
  )

  (func $storeDigit (param $digit i32) (param $digitPosition i32)
      get_local $digit
      call $digitToUtf8

      i32.const 20
      get_local $digitPosition
      i32.add

      i32.store8
  )

  (func $digitToUtf8 (param $digit i32) (result i32)
    get_local $digit
    i32.const 48
    i32.add
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

  (func $increment (param $n i32) (result i32)
    get_local $n
    i32.const 1
    i32.add
  )

)