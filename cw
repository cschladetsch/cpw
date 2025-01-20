#!/bin/bash

# Define the index file
index_file=".index"

# Show help and append the build date if no arguments are provided
if [ -z "$1" ]; then
    utc_date=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    echo "Usage: cw <target>"
    echo "Description:"
    echo "  - If <target> is alphabetic, it is treated as a filename to write to."
    echo "  - If <target> is numeric, the script uses it as an index to retrieve a file from .index."
    echo "  - If <target> is 'x<number>', the script opens the file at that index in vi."
    echo "When no arguments are provided, this message is displayed and the UTC build date is appended to .index."
    echo "Example: cw 0 (writes clipboard content to the 1st entry in .index, zero-based)"
    echo "         cw x1 (opens the file at index 1 in vi)"
    echo "         cw output.txt (writes clipboard content to 'output.txt')"
    echo "UTC Build Date: $utc_date"
    echo "# Build Date: $utc_date" >> "$index_file"
    exit 0
fi

# Handle the 'x<number>' case for vi
if [[ "$1" =~ ^x([0-9]+)$ ]]; then
    target="${BASH_REMATCH[1]}"
    
    # Check if the .index file exists
    if [ ! -f "$index_file" ]; then
        echo "Error: The required index file '.index' does not exist in the current directory."
        echo "Please create the file and add the list of file paths, one per line."
        exit 1
    fi

    # Get the file path from the .index file using the specified index
    file_path=$(sed -n "$((target + 1))p" "$index_file")

    # Check if the file path is empty (index out of bounds)
    if [ -z "$file_path" ]; then
        total_entries=$(wc -l < "$index_file")
        echo "Error: Index $target is out of range. The .index file contains $((total_entries - 1)) entries (zero-based)."
        echo "Ensure the index is within the range of 0 to $((total_entries - 1))."
        exit 1
    fi

    # Open the file in vi
    vi "$file_path"
    exit 0
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
    file_path=$(sed -n "$((target + 1))p" "$index_file")

    # Check if the file path is empty (index out of bounds)
    if [ -z "$file_path" ]; then
        total_entries=$(wc -l < "$index_file")
        echo "Error: Index $target is out of range. The .index file contains $((total_entries - 1)) entries (zero-based)."
        echo "Ensure the index is within the range of 0 to $((total_entries - 1))."
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

# Ensure the target directory exists
mkdir -p "$(dirname "$file_path")"

# Create the file if it doesn't exist
touch "$file_path"

# Write the clipboard content to the specified file
echo "$clipboard_content" > "$file_path"

# Confirm the operation
echo "Success: Clipboard content written to $file_path."
