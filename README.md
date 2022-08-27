# Hello miniaudio!

Playing audio with C++ using `miniaudio` library.

## Requirements

  - [miniaudio](https://github.com/mackron/miniaudio) or [mononerv/miniaudio](https://github.com/mononerv/miniaudio)

The miniaudio build script requires `ccache` to be installed on your system.

## Build

There are two ways to build this project `meson` or `shellscript`. Both requires you to download [miniaudio](https://github.com/mackron/miniaudio) (or [mononerv/miniaudio](https://github.com/mononerv/miniaudio)).

### shell

Make the `shell` scripts into an executable.

```
chmod +x run.sh
chmod +x miniaudio.sh
```

The `MINIAUDIO_SDK` environment variable needs to be set and point to the miniaudio directory.

Run the `miniaudio.sh` script first.

For running different `C++` file use the `run.sh` script. This will build and run the input `cpp` file.

```
./run.sh helloworld.cpp
```

### meson

Before you can run the meson setup script you'll need to run the `miniaudio.sh` to build the miniaudio static library. This will output the static library at `build` directory and the library include header will be at `build/include` which the meson script will look for as dependency.

```
meosn setup build
```

Use ninja to compile the code.

```
ninja -C build
```

