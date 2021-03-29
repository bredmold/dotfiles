# pyenv
if [ -d "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  __prepend_path "$PYENV_ROOT/bin"

  eval "$(pyenv init -)"
fi
