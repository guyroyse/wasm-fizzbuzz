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
      call $fizz
    else
      get_local $result
      i32.const -2
      i32.eq
      if
        call $buzz
      else
        get_local $result
        i32.const -3
        i32.eq
        if
          call $fizzbuzz
        else
          get_local $result
          call $number
        end
      end
    end
  )

  (func $fizz
    i32.const 0
    call $setHtmlResult
  )

  (func $buzz
    i32.const 5
    call $setHtmlResult
  )

  (func $fizzbuzz
    i32.const 10
    call $setHtmlResult
  )

  (func $number (param $n i32)
    get_local $n
    call $itoa
    call $setHtmlResult
  )

  (func $itoa (param $n i32) (result i32)
    (local $length i32)
    (local $divisor i32)

    get_local $n
    i32.eqz
    if ;; 0 is a special case
      i32.const 1
      set_local $length

      i32.const 0
      i32.const 0
      call $storeDigit
    else

      i32.const 1
      set_local $divisor

      i32.const 0
      set_local $length

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
          i32.
          set_local $divisor

          ;; loop again
          br 0
        end
      end



    end

    ;; store the length
    get_local $length
    call $storeLength

    ;; store the string
    i32.const 20

    ;; get the 1s place
    get_local $n
    i32.const 10
    i32.rem_u

    ;; add 48 to convert to UTF-8 for digits
    call $digitToUtf8
    i32.store8

    ;; return the position
    i32.const 19
  )
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


