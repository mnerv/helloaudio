#!/usr/bin/env sh
set -e

bin=build
obj=$bin/obj

in=$1
out="${in%.*}"

cpp_version=-std=c++20
warnings="-Wall -Wextra -Wpedantic -Werror -Wno-missing-field-initializers"
input_file=$1
target_dir=bin
include_dir="-I. -I$bin/include"
library_paths="-L./$bin"
library="${library_paths} -lminiaudio"
compile_flags="${cpp_version} ${warnings} ${include_dir} ${library}"

# create directories
mkdir -p $bin
mkdir -p $obj

# compile
ccache c++ $compile_flags $in -o $bin/$out

# run
./$bin/$out "${@:2}"

