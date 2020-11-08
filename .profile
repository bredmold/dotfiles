if [ $(uname) = "Darwin" ]; then
  # MacVim
  MVIM_DIR="/Applications/MacVim.app"
  if [ -d "$MVIM_DIR" ]; then
    alias mvim="$MVIM_DIR/Contents/bin/mvim"
  fi

  # Select JVM
  function jdk {
    if [ "$1" = "8" ]; then
      export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
    elif [ "$1" = "11" ]; then
      export JAVA_HOME=$(/usr/libexec/java_home -v 11)
    else
      echo "Unknown java version: $1"
    fi
  }
  GIT_COMPLETION='/Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash'
elif [[ "$(uname -r)" == *microsoft* ]]; then
  GIT_COMPLETION='/usr/share/bash-completion/bash_completion'

  eval $(ssh-agent)

  if [ "$DISPLAY" != "" ]; then
    export WSL_VERSION=$(wsl.exe -l -v | grep -a '[*]' | sed 's/[^0-9]*//g')
    export WSL_HOST=$(tail -1 /etc/resolv.conf | cut -d' ' -f2)
    export DISPLAY=$WSL_HOST:0
  fi
else
  GIT_COMPLETION='/usr/share/bash-completion/bash_completion'
fi

# pyenv
if [ -d "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
fi

# Git tab-completion
if [ -f "$GIT_COMPLETION" ]; then
  source "$GIT_COMPLETION"
fi

# Escape codes for prompting
__WHO_ESC='\[\e[35m\]'
__TIME_ESC='\[\e[36m\]'
__BRANCH_ESC='\[\e[1m\e[32m\]'
__WD_ESC='\[\e[34;1m\]'
__RESET_ESC='\[\e[0m\]'

# Determine the branch name
function __git_branch_name {
  local GIT_WD=$(pwd)

  while [ "$GIT_WD" != "/" ]; do
    DOT_GIT="$GIT_WD/.git"

    if [ -d "$DOT_GIT" ]; then
      __GIT_BRANCH_INDICATOR="${__BRANCH_ESC}($(git rev-parse --abbrev-ref HEAD))"
      return
    fi

    GIT_WD=$(dirname "$GIT_WD")
  done
  __GIT_BRANCH_INDICATOR=''
}

# Custom prompt
function __custom_prompt {
  __git_branch_name
  export PS1="${__WHO_ESC}\u@\h ${__TIME_ESC}[\t] ${__WD_ESC}\w ${__GIT_BRANCH_INDICATOR}${__RESET_ESC}\n\$ "
}
export PROMPT_COMMAND='__custom_prompt'
