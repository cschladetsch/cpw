#!/bin/bash

# Define the index file
index_file=".index"

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: cw <index>"
    echo "Description: Copies Windows clipboard contents to the file specified by <index> in .index."
    echo "Example: cw 2"
    exit 1
fi

# Extract the index from the argument
index="$1"

# Validate index is a positive integer
if ! [[ "$index" =~ ^[0-9]+$ ]] || [ "$index" -le 0 ]; then
    echo "Error: The index must be a positive integer."
    exit 1
fi

# Check if the .index file exists
if [ ! -f "$index_file" ]; then
    echo "Error: The required index file '.index' does not exist in the current directory."
    echo "Please create the file and add the list of file paths, one per line."
    exit 1
fi

# Get the file path from the .index file using the specified index
file_path=$(sed -n "${index}p" "$index_file")

# Check if the file path is empty (index out of bounds)
if [ -z "$file_path" ]; then
    total_entries=$(wc -l < "$index_file")
    echo "Error: Index $index is out of range. The .index file contains $total_entries entries."
    echo "Ensure the index is within the range of 1 to $total_entries."
    exit 1
fi

# Fetch clipboard content from Windows without loading the PowerShell profile
clipboard_content=$(powershell.exe -NoProfile -Command "Get-Clipboard" | tr -d '\r')

# Check if clipboard content is empty
if [ -z "$clipboard_content" ]; then
    echo "Error: No content found in Windows clipboard. Copy something to the clipboard and try again."
    exit 1
fi

#
