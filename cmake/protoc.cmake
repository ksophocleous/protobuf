set(protoc_files
  ${protobuf_source_dir}/src/google/protobuf/compiler/main.cc)

list(APPEND exportTargets protoc)
add_executable(protoc ${protoc_files})
target_link_libraries(protoc libprotobuf_static libprotoc_static)
