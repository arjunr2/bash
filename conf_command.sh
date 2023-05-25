#!/bin/bash
./configure --disable-threads --without-bash-malloc \
  CC=clang CC_FOR_BUILD=clang \
  CFLAGS="--target=wasm32 --sysroot=/home/arjun/Documents/research/webassembly/wali/wali-musl/sysroot -DNO_MAIN_ENV_ARG" \
  CFLAGS_FOR_BUILD="--target=wasm32 --sysroot=/home/arjun/Documents/research/webassembly/wali/wali-musl/sysroot -DNO_MAIN_ENV_ARG" \
  LD=wasm-ld LD_FOR_BUILD=wasm-ld \
  LDFLAGS="-Wl,--no-entry -Wl,--allow-undefined /home/arjun/tools/llvm-project/build-compiler-rt/libclang_rt.builtins-wasm32.a" \
  LDFLAGS_FOR_BUILD="-Wl,--no-entry -Wl,--allow-undefined /home/arjun/tools/llvm-project/build-compiler-rt/libclang_rt.builtins-wasm32.a" \
  AR=llvm-ar RANLIB=llvm-ranlib \
  cross_compiling=yes \
  CONFIG_SHELL=/bin/bash MAKE_SHELL=/bin/bash \
  SHELL=/bin/bash
  
