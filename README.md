# Hello miniaudio!

Playing audio with C++ using `miniaudio` library.

## Requirements

  - [miniaudio](https://github.com/mackron/miniaudio) or [mononerv/miniaudio](https://github.com/mononerv/miniaudio)

## Build

There are two ways to build this project `cmake` or `shellscript`. Both requires you to download [miniaudio](https://github.com/mackron/miniaudio) (or [mononerv/miniaudio](https://github.com/mononerv/miniaudio)). The `cmake` instructions requires you to have a built `miniaudio` static library. Both instructions requires you to define `MINIAUDIO_PATH` environment variables on your system that points to where the library header file exist.

### cmake

Create build script using the command below. You can specify `-G` flag to generate a specific build script, for example `-GNinja` for `ninja` or `-GXcode` to generate `Xcode` build system to use with Xcode IDE. Check out [CMake Generators](https://cmake.org/cmake/help/latest/manual/cmake-generators.7.html) for more info.

When building the static library make sure the output is either in `MINIAUDIO_PATH/lib` or in this project under `bin` directory. The `CMakeLists.txt` only searches for those two paths. This can be change in the `find_library` `PATHS` argument.

```
cmake -S . -Bbuild
```

Example with `ninja`:

```
cmake -S . -Bbuild -GNinja
```

Compile using `cmake` with command below.

```
cmake --build build -j4
```

### shell

Make the `shell` scripts into an executable.

```
chmod +x run.sh
chmod +x miniaudio.sh
```

The `MINIAUDIO_PATH` environment variable needs to be set and point to the miniaudio directory.

Run the `miniaudio.sh` script first.

For running different `C++` file use the `run.sh` script. This will build and run the input `cpp` file.

```
./run.sh helloworld.cpp
```

