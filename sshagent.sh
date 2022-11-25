function __find_agent {
  # Check for a file containing SSH-agent details
  if [ -f "$AGENT_DETAILS" ]; then
    SSH_AGENT_PID=$(jq -r .pid < "$AGENT_DETAILS")
    SSH_AUTH_SOCK=$(jq -r .sock < "$AGENT_DETAILS")

    if kill -n 0 "$SSH_AGENT_PID" && [ -S "$SSH_AUTH_SOCK" ]; then
      echo "Found agent pid $SSH_AGENT_PID"
      export SSH_AGENT_PID SSH_AUTH_SOCK
      return 0
    fi
  fi

  return 1
}

function __start_agent {
  eval $(ssh-agent)
  echo "{\"pid\":\"$SSH_AGENT_PID\",\"sock\":\"$SSH_AUTH_SOCK\"}" > "$AGENT_DETAILS"
}

SSH_AGENT=$(type -p ssh-agent)
AGENT_DETAILS="$HOME/.ssh/active-agent.json"
if [ -x "$SSH_AGENT" ]; then
  __find_agent || __start_agent
fi
