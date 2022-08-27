project('hellominiaudio', 'cpp',
    version: '0.0.0',
    default_options: [
        'cpp_std=c++20',
        'warning_level=3',
        'werror=true'
    ]
)
cpp = meson.get_compiler('cpp')
if build_machine.system() == 'darwin'
endif

miniaudio = declare_dependency(
    dependencies: cpp.find_library('miniaudio', dirs: join_paths(meson.source_root(), 'build')),
    include_directories: include_directories('build/include')
)
# thread = dependency('threads')
# fmt = dependency('fmt', version: '>=8.1.1', required: true)

executable('helloworld',
  [
    'helloworld.cpp'
  ],
  include_directories: [
    '.'
  ],
  dependencies: [
    miniaudio
#   thread,
#   fmt,
  ]
)

