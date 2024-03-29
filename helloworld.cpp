#include <iostream>
#include <cstdint>
#include <filesystem>

#include <vector>
#include <unordered_map>
#include <string>

#include "miniaudio.h"

auto data_callback(ma_device* p_device, void* p_output,
                  [[maybe_unused]]void const* p_input, ma_uint32 frame_count) -> void {
    ma_decoder* p_decoder = static_cast<ma_decoder*>(p_device->pUserData);
    if (p_device == nullptr) return;
    ma_data_source_read_pcm_frames(p_decoder, p_output, frame_count, nullptr);
}

auto main([[maybe_unused]]int argc, [[maybe_unused]]char const* argv[]) -> int {
    if (argc < 2) {
        std::cerr << "No input file.\n\n";
        std::cout << "usage: " << argv[0] << " [path]\n";
        std::cout << "supported files: [mp3,flac,wav]\n";
        return 1;
    }

    auto filename = argv[1];
    ma_decoder decoder{};
    if (ma_decoder_init_file(filename, nullptr, &decoder) != MA_SUCCESS)
        return 2;

    //ma_data_source_set_looping(&decoder, MA_TRUE);

    auto device_config = ma_device_config_init(ma_device_type_playback);
    device_config.playback.format   = decoder.outputFormat;
    device_config.playback.channels = decoder.outputChannels;
    device_config.sampleRate        = decoder.outputSampleRate;
    device_config.dataCallback      = data_callback;
    device_config.pUserData         = &decoder;

    ma_device device{};
    if (ma_device_init(nullptr, &device_config, &device) != MA_SUCCESS) {
        std::cerr << "Failed to open playback device.\n";
        ma_decoder_uninit(&decoder);
        return 3;
    }

    if (ma_device_start(&device) != MA_SUCCESS) {
        std::cerr << "Failed to start playback device.\n";
        ma_device_uninit(&device);
        ma_decoder_uninit(&decoder);
        return 4;
    }

    std::filesystem::path file{filename};
    std::cout << "Now playing: " << file.filename() << "\n";

    std::cout << "Press enter to quit...";
    std::cin.get();

    ma_device_uninit(&device);
    ma_decoder_uninit(&decoder);

    return 0;
}

