#!/bin/bash

# Define the index file
index_file=".index"

# Check if an argument is provided
if [ -z "$1" ]; then
    echo "Usage: cw <target>"
    echo "Description:"
    echo "  - If <target> is alphabetic, it is treated as a filename to write to."
    echo "  - If <target> is numeric, the script uses it as an index to retrieve a file from .index."
    echo "Example: cw 2 (uses the 2nd entry in .index)"
    echo "         cw output.txt (writes to 'output.txt')"
    exit 1
fi

# Determine if the argument is numeric or alphabetic
target="$1"
if [[ "$target" =~ ^[0-9]+$ ]]; then
    # Numeric: Index into .index file

    # Check if the .index file exists
    if [ ! -f "$index_file" ]; then
        echo "Error: The required index file '.index' does not exist in the current directory."
        echo "Please create the file and add the list of file paths, one per line."
        exit 1
    fi

    # Get the file path from the .index file using the specified index
    file_path=$(sed -n "${target}p" "$index_file")

    # Check if the file path is empty (index out of bounds)
    if [ -z "$file_path" ]; then
        total_entries=$(wc -l < "$index_file")
        echo "Error: Index $target is out of range. The .index file contains $total_entries entries."
        echo "Ensure the index is within the range of 1 to $total_entries."
        exit 1
    fi
else
    # Alphabetic: Use the target directly as the file name
    file_path="$target"
fi

# Fetch clipboard content from Windows without loading the PowerShell profile
clipboard_content=$(powershell.exe -NoProfile -Command "Get-Clipboard" | tr -d '\r')

# Check if clipboard content is empty
if [ -z "$clipboard_content" ]; then
    echo "Error: No content found in Windows clipboard. Copy something to the clipboard and try again."
    exit 1
fi

# Ensure the target file exists (create it if necessary)
mkdir -p "$(dirname "$file_path")"
touch "$file_path"

# Write the clipboard content to the specified file
echo "$clipboard_content" > "$file_path"

# Confirm the operation
echo "Success: Clipboard content written to $file_path."

