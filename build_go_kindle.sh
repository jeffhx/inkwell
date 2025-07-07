#!/bin/bash

# Build script for Inkwell Go version targeting Kindle devices

set -e

# Environment variables for cross-compilation
export GOOS=linux
export GOARCH=arm
export GOARM=5
export CGO_ENABLED=0
export GOMEMLIMIT=16MiB
export GOGC=50

GO_FILE="inkwell.go"
OUTPUT="inkwell-${GOARCH}${GOARM}"

# Remove existing binary if it exists
if [ -f "$OUTPUT" ]; then
    rm "$OUTPUT"
fi

echo "Compiling $GO_FILE for Kindle (ARMv${GOARM})..."

# Build the Go binary with optimizations
go build -trimpath -o "$OUTPUT" -ldflags="-s -w" "$GO_FILE"

# Check if compilation was successful
if [ -f "$OUTPUT" ]; then
    echo "Compilation successful! Output file: $OUTPUT"
    ls -lh "$OUTPUT"
else
    echo "Compilation failed."
    exit 1
fi