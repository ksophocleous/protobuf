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
	list(APPEND compile_definitions
		"LIBPROTOBUF_EXPORTS"
		"PROTOBUF_USE_DLLS")
	list(APPEND interface_compile_definitions
		"PROTOBUF_USE_DLLS")
endif()

add_library(libprotobuf-lite ${libprotobuf_lite_files} ${libprotobuf_lite_hdrs})
target_link_libraries(libprotobuf-lite ${CMAKE_THREAD_LIBS_INIT} ${additional_libs})
set_target_properties(libprotobuf-lite PROPERTIES
	COMPILE_FLAGS "${compile_flags}"
	COMPILE_DEFINITIONS "${compile_definitions}"
	INTERFACE_COMPILE_DEFINITIONS "${interface_compile_definitions}"
	IMPORT_PREFIX ""
	IMPORT_SUFFIX _imp${CMAKE_IMPORT_LIBRARY_SUFFIX}
	INTERFACE_INCLUDE_DIRECTORIES "$<BUILD_INTERFACE:${protobuf_source_dir}/src>;$<INSTALL_INTERFACE:include>"
	INCLUDE_DIRECTORIES "${protobuf_source_dir}/src"
	PREFIX "")

install(TARGETS libprotobuf-lite
	EXPORT ${CMAKE_PROJECT_NAME}Config
	LIBRARY DESTINATION lib COMPONENT dev
	ARCHIVE DESTINATION lib COMPONENT dev
	RUNTIME DESTINATION bin COMPONENT bin)
