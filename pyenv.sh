# pyenv
if [ -d "$HOME/.pyenv" ]; then
  __prepend_path "$HOME/.pyenv/bin"

  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi
