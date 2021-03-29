GIT_COMPLETION='/usr/share/bash-completion/bash_completion'

eval $(ssh-agent)

if [ "$DISPLAY" != "" ]; then
  export WSL_VERSION=$(wsl.exe -l -v | grep -a '[*]' | sed 's/[^0-9]*//g')
  export WSL_HOST=$(tail -1 /etc/resolv.conf | cut -d' ' -f2)
  export DISPLAY=$WSL_HOST:0
fi

# Add VS Code to the path
VS_CODE='/mnt/c/Users/Aaron Goldstein/AppData/Local/Programs/Microsoft VS Code'
__prepend_path "$VS_CODE/bin"
