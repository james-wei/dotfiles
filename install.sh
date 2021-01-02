#!/bin/sh

repo_root="$(dirname $0)"
cd "${repo_root}"

# Install .zshrc
if [ -s "${HOME}/.zshrc" ]; then
  mv "${HOME}/.zshrc" "${HOME}/.zshrc.$(date +%s).bak"
fi
[ -s ".zshrc" ] && cp -a ".zshrc" "${HOME}/.zshrc"

# Install tmux conf
if [ -s "${HOME}/.tmux.conf" ]; then
  mv "${HOME}/.tmux.conf" "${HOME}/.tmux.conf.$(date +%s).bak"
fi
[ -s ".tmux.conf" ] && cp -a ".tmux.conf" "${HOME}/.tmux.conf"

# Install .vimrc
if [ -s "${HOME}/.vimrc" ]; then
  mv "${HOME}/.vimrc" "${HOME}/.vimrc.$(date +%s).bak"
fi
[ -s ".vimrc" ] && cp -a ".vimrc" "${HOME}/.vimrc"

# Configure vim-plug + install plugins
curl -fLso ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
/bin/zsh -c "vim +PlugUpgrade +qall &> /dev/null"
/bin/zsh -c "vim +PlugInstall +qall &> /dev/null"
/bin/zsh -c "vim +PlugUpdate +qall &> /dev/null"
/bin/zsh -c "vim +PlugClean! +qall &> /dev/null"

# Patch gruvbox Vim colorscheme
if [ -s "${HOME}/.vim/plugged/gruvbox/colors/gruvbox.vim" ]; then
  patch "${HOME}/.vim/plugged/gruvbox/colors/gruvbox.vim" -s -i gruvbox_cul_highlight.patch --dry-run
  if [ $? -eq 0 ]; then
    patch "${HOME}/.vim/plugged/gruvbox/colors/gruvbox.vim" -s -i gruvbox_cul_highlight.patch
  else
    echo 'Could not patch gruvbox, skipping...'
  fi
fi

echo 'Done!'
