# jEnv
if [ -d "$HOME/.jenv" ]; then
  __prepend_path "$HOME/.jenv/bin"
  eval "$(jenv init -)"
fi
