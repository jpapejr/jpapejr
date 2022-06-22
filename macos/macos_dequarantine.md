To view MacOS file attributes: `xattr -l /PATH/TO/SCRIPTYOUCANTRUN.sh`

To remove an errant `com.apple.quarantine` flag from your shell script: `xattr -d com.apple.quarantine /PATH/TO/SCRIPTYOUCANTRUN.sh`

> Reference: https://www.alansiu.net/2021/08/19/troubleshooting-zsh-operation-not-permitted/
