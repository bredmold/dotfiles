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
  elif [ "$1" = "17" ]; then
    export JAVA_HOME=$(/usr/libexec/java_home -v 17)
  else
    echo "Unknown java version: $1"
  fi
}
GIT_COMPLETION='/Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash'
alias ls='ls -GF'

# HomeBrew
__prepend_path "/opt/homebrew/bin"
