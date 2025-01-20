# Clipboard to Indexed File

`cw` is a versatile Bash script designed to manage the Windows clipboard content and file operations in WSL (Windows Subsystem for Linux). It can copy clipboard content to specific files, open indexed files in `vi`, or simply display usage instructions and log the current UTC build date.

## Features

- **Copy Clipboard Content**: Writes clipboard content to a specified file or to a file indexed in `.index`.
- **Open Indexed Files**: Opens files from `.index` in `vi` using a zero-based index.
- **Log UTC Build Date**: When called with no arguments, appends the current UTC build date to `.index` and displays help instructions.

## Usage

```bash
cw <target>
```

### Arguments

1. **Alphabetic File Name**:
   - If `<target>` starts with a letter, it is treated as a filename.
   - Example: `cw output.txt` writes clipboard content to `output.txt`.

2. **Numeric Index**:
   - If `<target>` is a number, it is treated as a zero-based index into the `.index` file.
   - Example: `cw 0` writes clipboard content to the first file in `.index`.

3. **Open in `vi`**:
   - Use `x<number>` to open the file at the specified zero-based index in `vi`.
   - Example: `cw x1` opens the second file in `.index`.

4. **No Arguments**:
   - Displays usage instructions and appends the current UTC build date to `.index`.

### Example `.index` File

```text
src/main.cpp
src/displace.cpp
include/display.hpp
```

### Commands

1. **Copy Clipboard to Indexed File**:
   ```bash
   cw 0
   ```
   Writes clipboard content to `src/main.cpp` (first entry in `.index`).

2. **Open File in `vi`**:
   ```bash
   cw x1
   ```
   Opens `src/displace.cpp` (second entry in `.index`) in `vi`.

3. **Log UTC Build Date**:
   ```bash
   cw
   ```
   Appends the current UTC build date as a comment to `.index` and displays:
   ```
   UTC Build Date: 2025-01-20T08:01:44Z
   ```

## Error Handling

- **Missing `.index` File**: Displays a helpful message if `.index` does not exist.
- **Out-of-Range Index**: Alerts when a numeric index exceeds the number of entries in `.index`.
- **Empty Clipboard**: Informs the user when the clipboard is empty.

## Requirements

- **WSL**: Windows Subsystem for Linux.
- **PowerShell**: Accessible as `powershell.exe` to fetch clipboard content.

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/cschladetsch/cw.git
   ```
2. Navigate to the script's directory and make it executable:
   ```bash
   chmod +x cw
   ```
3. (Optional) Add the script's directory to your PATH:
   ```bash
   echo 'export PATH=$PATH:/path-to-cw-script' >> ~/.bashrc
   source ~/.bashrc
   ```

## License

This project is licensed under the MIT License.
