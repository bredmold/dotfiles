GIT_COMPLETION='/usr/share/bash-completion/bash_completion'

# Create Mac work-alike pbcopy/pbpaste aliases
alias pbcopy='clip.exe'
alias pbpaste='powershell.exe Get-Clipboard'

# Configure NPM
NPM_PACKAGES="$HOME/.npm-packages"
__mkdir "$NPM_PACKAGES"
__mkdir "$NPM_PACKAGES/bin"
__mkdir "$NPM_PACKAGES/share/man"
__mkdir "$NPM_PACKAGES/lib/node_modules"

__rcfile_line "$HOME/.npmrc" "prefix = $NPM_PACKAGES"
__prepend_path_var "$NPM_PACKAGES/bin" PATH
__prepend_path_var "$NPM_PACKAGES/share/man" MANPATH
__prepend_path_var "$NPM_PACKAGES/lib/node_modules" NODE_PATH
