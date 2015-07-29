cmake_minimum_required(VERSION 3.0)

project(protobuf VERSION 3.0.0)

option(BUILD_TESTING "Build tests" OFF)
option(BUILD_SHARED_LIBS "Build Shared Libraries" OFF)
option(USE_ZLIB "Build with zlib support" OFF)
if(MSVC)
	OPTION(LINK_STATIC_RUNTIME "Link with msvc static runtime" OFF)
endif()

# debug libraries can coexist with release libraries, so make debug names different
set(CMAKE_DEBUG_POSTFIX "d")

add_definitions(-DGOOGLE_PROTOBUF_CMAKE_BUILD)

find_package(Threads REQUIRED)
if(CMAKE_USE_PTHREADS_INIT)
	add_definitions(-DHAVE_PTHREAD)
endif()

# statically link msvc runtime
if(MSVC AND LINK_STATIC_RUNTIME)
	message(STATUS "Linking runtime statically")
	foreach(flag_var
		CMAKE_C_FLAGS CMAKE_C_FLAGS_DEBUG CMAKE_C_FLAGS_RELEASE
		CMAKE_C_FLAGS_MINSIZEREL CMAKE_C_FLAGS_RELWITHDEBINFO
		CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE
		CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO)

		if(${flag_var} MATCHES "/MD")
			string(REGEX REPLACE "/MD" "/MT" ${flag_var} "${${flag_var}}")
		endif(${flag_var} MATCHES "/MD")
	endforeach(flag_var)
endif()

if(USE_ZLIB)
	# config flag tells cmake not to use the build-in package file to find zlib but
	# switch to config mode where it tries to find the config file provided by
	# the package
	find_package(zlib REQUIRED CONFIG)
	list(APPEND compile_definitions "HAVE_ZLIB")
	list(APPEND additional_libs "zlib")
endif()

if (MSVC)
	list(APPEND compile_flags
		"/wd4244 /wd4267 /wd4018 /wd4355 /wd4800 /wd4251 /wd4996 /wd4146 /wd4305")

	string(REPLACE "/" "\\" PROTOBUF_SOURCE_WIN32_PATH ${protobuf_SOURCE_DIR})
	string(REPLACE "/" "\\" PROTOBUF_BINARY_WIN32_PATH ${protobuf_BINARY_DIR})
	configure_file(extract_includes.bat.in extract_includes.bat)
endif()

# strips the cmake part in the path
get_filename_component(protobuf_source_dir ${protobuf_SOURCE_DIR} PATH)
set(protobuf_public_hdr_dir "${protobuf_source_dir}/src")

add_subdirectory(libprotobuf-lite)
add_subdirectory(libprotobuf)
add_subdirectory(libprotoc)
add_subdirectory(protoc)

if (BUILD_TESTING)
	include(tests.cmake)
endif()

install(DIRECTORY "${protobuf_source_dir}/src/google"
	DESTINATION "include" COMPONENT dev
	FILES_MATCHING
	PATTERN "*.h")

install(EXPORT ${CMAKE_PROJECT_NAME}Config
	DESTINATION lib/cmake)
