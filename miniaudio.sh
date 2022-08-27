#!/usr/bin/env sh
set -e

in=miniaudio.c
out="${in%.*}"

bin=build
obj=$bin/obj

c_version=-std=c18
warnings="
 -Wall
 -Wextra
 -Werror
 -Wno-deprecated-declarations
 -Wno-unused-but-set-variable
"
includes="-I. -I${MINIAUDIO_SDK}"
other="-O3"
compile_flags="${c_version} ${warnings} ${includes} ${other}"

mkdir -p $bin
mkdir -p $obj

ccache cc $compile_flags -c $in -o $obj/${out}
ccache ar rcs $bin/lib${out}.a $obj/${out}
ccache cp ${MINIAUDIO_SDK}/miniaudio.h $bin

