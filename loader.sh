function __read_rc_file {
  local rc="$1"

  if [ -f "$rc" ]; then
    . "$rc"
  else
    echo "Not found: $rc"
  fi
}

function __prepend_path {
  local entry="$1"

  if [ -d "$entry" ]; then
    if ! echo "$PATH" | tr : $'\n' | grep "$entry" > /dev/null; then
      export PATH="$entry:$PATH"
    fi
  fi
}

if [ -d "$1" ]; then
  if [ $(uname) = "Darwin" ]; then
    __read_rc_file "$1/osx.sh"
  elif [[ "$(uname -r)" == *microsoft* ]]; then
    __read_rc_file "$1/wsl2.sh"
  else
    __read_rc_file "$1/other_os.sh"
  fi

  __read_rc_file "$1/git.sh"
  __read_rc_file "$1/pyenv.sh"
  __read_rc_file "$1/sshagent.sh"

  __prepend_path "$HOME/.npm-global/bin"
  __prepend_path "$HOME/bin"
fi
