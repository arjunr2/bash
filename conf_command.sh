#!/bin/bash

SYSROOT_DIR=/home/arjun/Documents/research/webassembly/wali/wali-musl/sysroot
cflag_warning_ign="-Wno-implicit-function-declaration -Wno-int-conversion -Wno-incompatible-function-pointer-types"
wali_cflags="-O0 --target=wasm32-wasi-threads $cflag_warning_ign --sysroot=$SYSROOT_DIR -L$SYSROOT_DIR/lib -matomics -mbulk-memory -mmutable-globals -msign-ext"
wali_lflags="-Wl,--shared-memory -Wl,--export-memory -Wl,--max-memory=67108864"

./configure --disable-threads --without-bash-malloc \
  CC=clang  \
  CFLAGS="$wali_cflags -DNO_MAIN_ENV_ARG" \
  LD=wasm-ld \
  LDFLAGS="$wali_lflags" \
  CC_FOR_BUILD=clang \
  CFLAGS_FOR_BUILD="$wali_cflags -DNO_MAIN_ENV_ARG" \
  LD_FOR_BUILD=wasm-ld \
  LDFLAGS_FOR_BUILD="$wali_lflags" \
  AR=llvm-ar RANLIB=llvm-ranlib \
  cross_compiling=yes \
  CONFIG_SHELL=/bin/bash MAKE_SHELL=/bin/bash \
  SHELL=/bin/bash


#CC=clang \
#CFLAGS="--target=wasm32 --sysroot=/home/arjun/Documents/research/webassembly/wali/wali-musl/sysroot -DNO_MAIN_ENV_ARG" \
#LD=wasm-ld \
#LDFLAGS="-Wl,--no-entry -Wl,--allow-undefined /home/arjun/tools/llvm-project/build-compiler-rt/libclang_rt.builtins-wasm32.a" \
