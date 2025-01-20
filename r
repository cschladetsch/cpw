#!/bin/bash

# Script: build_and_test.sh

# Set the build directory
BUILD_DIR="build"

# Create or clean the build directory
if [ -d "$BUILD_DIR" ]; then
    echo "Cleaning build directory..."
    rm -rf "$BUILD_DIR"
fi
mkdir "$BUILD_DIR"

# Run CMake configuration
echo "Configuring CMake project..."
cmake -S . -B "$BUILD_DIR"

# Build the project
echo "Building project..."
cmake --build "$BUILD_DIR" --config Release

# Run the tests
echo "Running tests..."
cd "$BUILD_DIR" || exit
ctest --output-on-failure
