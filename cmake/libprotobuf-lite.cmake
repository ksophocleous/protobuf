set(libprotobuf_lite_hdrs
    )

set(libprotobuf_lite_files
    ${protobuf_source_dir}/src/google/protobuf/arena.cc
    ${protobuf_source_dir}/src/google/protobuf/arenastring.cc
    ${protobuf_source_dir}/src/google/protobuf/extension_set.cc
    ${protobuf_source_dir}/src/google/protobuf/generated_message_util.cc
    ${protobuf_source_dir}/src/google/protobuf/io/coded_stream.cc
    ${protobuf_source_dir}/src/google/protobuf/io/zero_copy_stream.cc
    ${protobuf_source_dir}/src/google/protobuf/io/zero_copy_stream_impl_lite.cc
    ${protobuf_source_dir}/src/google/protobuf/message_lite.cc
    ${protobuf_source_dir}/src/google/protobuf/repeated_field.cc
    ${protobuf_source_dir}/src/google/protobuf/stubs/atomicops_internals_x86_gcc.cc
    ${protobuf_source_dir}/src/google/protobuf/stubs/atomicops_internals_x86_msvc.cc
    ${protobuf_source_dir}/src/google/protobuf/stubs/bytestream.cc
    ${protobuf_source_dir}/src/google/protobuf/stubs/common.cc
    ${protobuf_source_dir}/src/google/protobuf/stubs/once.cc
    ${protobuf_source_dir}/src/google/protobuf/stubs/status.cc
    ${protobuf_source_dir}/src/google/protobuf/stubs/statusor.cc
    ${protobuf_source_dir}/src/google/protobuf/stubs/stringpiece.cc
    ${protobuf_source_dir}/src/google/protobuf/stubs/stringprintf.cc
    ${protobuf_source_dir}/src/google/protobuf/stubs/strutil.cc
    ${protobuf_source_dir}/src/google/protobuf/stubs/time.cc
    ${protobuf_source_dir}/src/google/protobuf/wire_format_lite.cc
    )

if(BUILD_SHARED_LIBS)
    list(APPEND exportTargets libprotobuf-lite)
    add_library(libprotobuf-lite SHARED ${libprotobuf_lite_files} ${libprotobuf_lite_hdrs})
    target_link_libraries(libprotobuf-lite ${CMAKE_THREAD_LIBS_INIT})
    set_target_properties(libprotobuf-lite PROPERTIES
        COMPILE_DEFINITIONS "${compile_definitions};LIBPROTOBUF_EXPORTS;PROTOBUF_USE_DLLS"
        INTERFACE_COMPILE_DEFINITIONS "PROTOBUF_USE_DLLS"
        IMPORT_PREFIX ""
        IMPORT_SUFFIX _imp${CMAKE_IMPORT_LIBRARY_SUFFIX}
        INTERFACE_INCLUDE_DIRECTORIES "$<BUILD_INTERFACE:${protobuf_source_dir}/src>;$<INSTALL_INTERFACE:include>"
        INCLUDE_DIRECTORIES "${protobuf_source_dir}/src"
        PREFIX "")
endif()

list(APPEND exportTargets libprotobuf-lite_static)
add_library(libprotobuf-lite_static STATIC ${libprotobuf_lite_files} ${libprotobuf_lite_hdrs})
target_link_libraries(libprotobuf-lite_static ${CMAKE_THREAD_LIBS_INIT} ${ZLIB_LIBRARIES})
set_target_properties(libprotobuf-lite_static PROPERTIES
    COMPILE_DEFINITIONS "${compile_definitions}"
    INTERFACE_INCLUDE_DIRECTORIES "$<BUILD_INTERFACE:${protobuf_source_dir}/src>;$<INSTALL_INTERFACE:include>"
    INCLUDE_DIRECTORIES "${protobuf_source_dir}/src"
    PREFIX "")
