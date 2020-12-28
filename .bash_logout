if [ "$SSH_AGENT_PID" != "" ]; then
  eval $(ssh-agent -k)
  rm -f "$HOME/.ssh/agent"
fi
