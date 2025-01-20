cmake_minimum_required(VERSION 3.14)
project(CW_Tests)

# Enable testing
enable_testing()

# Check for Catch2 header-only library
find_package(Catch2 CONFIG QUIET)

if (NOT Catch2_FOUND)
    # Fetch Catch2 if not found
    include(FetchContent)
    FetchContent_Declare(
        catch2
        GIT_REPOSITORY https://github.com/catchorg/Catch2.git
        GIT_TAG v3.4.0 # Specify the version or branch
    )
    FetchContent_MakeAvailable(catch2)
endif()

# Add test executable
add_executable(tests test_main.cpp)

# Link Catch2 to the test executable
if (Catch2_FOUND)
    target_link_libraries(tests PRIVATE Catch2::Catch2)
else()
    # Use Catch2 as a header-only library if FetchContent fetched it
    target_include_directories(tests PRIVATE ${catch2_SOURCE_DIR}/single_include)
endif()

# Add test execution
include(CTest)
add_test(NAME ExampleTest COMMAND tests)
