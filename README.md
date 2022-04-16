# Hello miniaudio!

Playing audio with C++ using `miniaudio` library.

## Requirements

  - [miniaudio](https://github.com/mackron/miniaudio)

## Build

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

