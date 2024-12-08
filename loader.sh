function __read_rc_file {
  local rc="$1"

  if [ -f "$rc" ]; then
    . "$rc"
  else
    echo "Not found: $rc"
  fi
}

function __mkdir {
  local path="$1"

  if [ ! -d "$path" ]; then
    mkdir -p "$path"
  fi
}

function __prepend_path_var {
  local entry="$1"
  local var="$2"
  local path_value=$(eval "echo -n \$$var")

  echo "$var=[$path_value]"
  if [ -d "$entry" ] && [ "$path_value" = "" ]; then
    eval "export $var=\"$entry\""
  elif [ -d "$entry" ] && ! echo "$path_value" | tr : $'\n' | grep "$entry" > /dev/null; then
    eval "export $var=\"$entry:$path_value\""
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

function __rcfile_line {
  local path="$1"

  shift
  local line="$*"

  if [ ! -f "$path" ] || ! grep "$line" "$path" > /dev/null; then
    echo "$line" >> "$path"
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
  __read_rc_file "$1/nvm.sh"
  __read_rc_file "$1/jenv.sh"
  __read_rc_file "$1/sshagent.sh"

  __prepend_path "$HOME/.npm-global/bin"
  __prepend_path "$HOME/bin"
fi
