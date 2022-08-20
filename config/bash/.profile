export PATH=$HOME/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export GOPATH=$HOME/.go
if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi
