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
  local DOT_GIT

  while [ "$GIT_WD" != "/" ]; do
    DOT_GIT="$GIT_WD/.git"

    if [ -d "$DOT_GIT" ]; then
      __GIT_BRANCH_INDICATOR="${__BRANCH_ESC}($(git rev-parse --abbrev-ref HEAD 2> /dev/null))"
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
