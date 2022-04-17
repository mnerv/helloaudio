#!/usr/bin/env sh
set -e

in=miniaudio.c
out="${in%.*}"

bin=bin
obj=obj

c_version=-std=c18
warnings="-Wall -Wextra"
includes="-I. -I${MINIAUDIO_PATH}"
other="-O3"
compile_flags="${c_version} ${warnings} ${includes} ${other}"

mkdir -p $bin
mkdir -p $obj

cc $compile_flags -c $in -o $obj/${out}
ar rcs $bin/lib${out}.a $obj/${out}

