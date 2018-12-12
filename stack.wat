(module

  (import "js" "memory" (memory 1))

  (export "push" (func $push))
  (export "pop" (func $pop))
  (export "peek" (func $peek))
  (export "size" (func $size))

  (func $push (param $item i32)
    (call $incrementSize)
    (i32.store
      (i32.mul (i32.const 4) (call $size))
      (get_local $item)
    )
  )

  (func $pop (result i32)
    (local $result i32)

    (set_local $result (call $peek))

    (if
      (i32.ne (i32.const -1) (get_local $result))
      (then (call $decrementSize))
    )

    (get_local $result)
  )

  (func $peek (result i32)
    (local $result i32)
    (if
      (i32.eqz (call $size))
      (then
        (set_local $result (i32.const -1))
      )
      (else
        (set_local $result (call $size))
      )
    )
    (get_local $result)
  )

  (func $size (result i32)
    (i32.load (i32.const 0))
  )

  (func $incrementSize
    (call $updateSize
      (i32.add (call $size) (i32.const 1))
    )
  )

  (func $decrementSize
    (call $updateSize
      (i32.sub (call $size) (i32.const 1))
    )
  )

  (func $updateSize (param $newSize i32)
    (i32.store (i32.const 0) (get_local $newSize))
  )
)
