set(sources "${protobuf_source_dir}/src/google/protobuf/compiler/main.cc")

add_executable(protoc ${sources})
target_link_libraries(protoc libprotobuf libprotoc)

install(TARGETS protoc
	EXPORT ${CMAKE_PROJECT_NAME}Config
	LIBRARY DESTINATION lib COMPONENT dev
	ARCHIVE DESTINATION lib COMPONENT dev
	RUNTIME DESTINATION bin COMPONENT bin)
