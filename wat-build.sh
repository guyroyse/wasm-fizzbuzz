# clear out the old files
rm *.wasm

# In order to build a WebAssembly module written in WebAssembly
# Text Format, you need to download and compile the WebAssembly
# Binary Toolkit:
#
#   https://github.com/WebAssembly/wabt
#
# Once installed, add it to your path like this:
#
#   export PATH=$PATH:~/wabt/build
#
# Or don't. Don't let me tell you how to live your life!
#

# assemble the code
wat2wasm controller.wat
wat2wasm math.wat
wat2wasm model.wat
wat2wasm stack.wat
wat2wasm strings.wat
wat2wasm view.wat
