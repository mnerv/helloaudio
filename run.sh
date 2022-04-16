#!/usr/bin/env sh

# Build and run the target file
set -e

bin=bin
obj=obj

cpp_version=-std=c++20
warnings="-Wall -Wextra -Wpedantic -Werror -Wno-missing-field-initializers"
input_file=$1
target_dir=bin
include_dir="-I. -I${MINIAUDIO_PATH}"
library="-L./bin -lminiaudio"
compile_flags="${cpp_version} ${warnings} ${include_dir} ${library}"

input=$1
output="${input%.*}"

c++ $compile_flags $input -o $bin/$output

./bin/$output

