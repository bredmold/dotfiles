GIT_COMPLETION='/usr/share/bash-completion/bash_completion'

# Create Mac work-alike pbcopy/pbpaste aliases
alias pbcopy='clip.exe'
alias pbpaste='powershell.exe Get-Clipboard'

# Add VS Code to the path
VS_CODE='/mnt/c/Users/Aaron Goldstein/AppData/Local/Programs/Microsoft VS Code'
__prepend_path "$VS_CODE/bin"
