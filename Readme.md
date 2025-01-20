
# cw: Clipboard to Indexed File

`cw` is a Bash script designed to copy the contents of the Windows clipboard to a file specified by its index in a `.index` file. It is particularly useful for developers using WSL (Windows Subsystem for Linux) who work with multiple target files.

The script reads the file paths from a `.index` file located in the current directory. Each line in `.index` corresponds to a file, indexed by its line number. For example, if `.index` contains the following:

```
src/main.cpp
src/displace.cpp
include/display.hpp
```

Running `cw 2` will write the clipboard content to `src/displace.cpp`.

The script provides robust error handling:
- If the `.index` file is missing, it prompts you to create it and explains its purpose.
- If the specified index is out of range, it informs you of the valid range based on the number of entries in `.index`.
- If the clipboard is empty, it notifies you and suggests copying content before retrying.

### Requirements
The script requires WSL with `powershell.exe` available in your system's PATH to fetch clipboard content from Windows.

### Installation
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

### Usage
To use the script, ensure a `.index` file exists in the current directory with file paths, one per line. Then run:
```bash
cw <index>
```
Replace `<index>` with the line number of the target file in `.index`. For example:
```bash
cw 2
```
This writes the clipboard content to the file specified on the second line of `.index`.

### License
This project is licensed under the MIT License.
