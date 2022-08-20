#!/bin/sh
CURRENT=$(cd $(dirname $0); pwd)

mkdir -p ~/.config
mkdir -p ~/.config/nvim

ln -sf $CURRENT/bash/.bash_aliases ~/.bash_aliases
ln -sf $CURRENT/bash/.bash_profile ~/.bash_profile
ln -sf $CURRENT/bash/.bashrc ~/.bashrc
ln -sf $CURRENT/bash/.profile ~/.profile
ln -sf $CURRENT/code-server/keybindings.json ~/.local/share/code-server/User/keybindings.json
ln -sf $CURRENT/code-server/settings.json ~/.local/share/code-server/User/settings.json
ln -sf $CURRENT/vim/.vimrc ~/.vimrc
ln -sf $CURRENT/vim/init.vim ~/.config/nvim/init.vim
ln -sf $CURRENT/.gitconfig ~/.gitconfig
ln -sf $CURRENT/.irbrc ~/.irbrc
ln -sf $CURRENT/.tmux.conf ~/.tmux.conf

touch ~/.irb_history

echo "The dotfiles link process was successful."
