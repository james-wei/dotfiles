# dotfiles

Yet another collection of ZSH, Vim, and tmux configs

## 1. Set up packages

### Debian + Ubuntu (with root)
#### Update existing packages
```
sudo apt -yq update && sudo apt -yq upgrade && sudo apt -yq full-upgrade
```
#### Install new packages
```
[[ ! $(command -v curl) ]] && sudo apt -yq install curl
[[ ! $(command -v zsh) ]] && sudo apt -yq install zsh
[[ ! $(command -v git) ]] && sudo apt -yq install git
[[ ! $(command -v vim) ]] && sudo apt -yq install vim
[[ ! $(command -v tmux) ]] && sudo apt -yq install tmux
[[ ! $(command -v rg) ]] && sudo apt -yq install ripgrep
[[ ! $(command -v rsync) ]] && sudo apt -yq install rsync
```
#### Clean up
```
sudo apt -yq autoremove && sudo apt -yq clean
```

### Debian + Ubuntu (without root)
When access to the package management system is restricted (e.g., on a
shared development machine), we can optionally compile local copies of
our desired packages. This is helpful both when a package does not
exist and when an existing package is out of date.

We store locally compiled binaries and their respective assets in
`$HOME/.local`.

For instance, building a local copy of ZSH might look something like:
```
wget -O zsh.tar.xz https://sourceforge.net/projects/zsh/files/zsh/5.8/zsh-5.8.tar.xz/download
tar xf zsh.tar.xz && cd zsh-5.8
./configure --prefix=$HOME/.local
make && make install
```

The example above is for `zsh-5.8`; check
[here](zsh.sourceforge.net/Arc/source.html) for information about the
latest ZSH release.

Building a local copy of tmux might look something like:
```
wget -O tmux.tar.gz https://github.com/tmux/tmux/releases/download/3.1c/tmux-3.1c.tar.gz
tar xf tmux.tar.gz && cd tmux-3.1c
./configure --prefix=$HOME/.local
make && make install
```

The example above is for `tmux-3.1c`; check
[here](https://github.com/tmux/tmux/releases) for information about the
latest tmux release.

**Note**: Unless they are already available on the target system, we may
also need to compile dependencies, e.g., `ncurses` must be built before
compiling ZSH.

### macOS
#### Install Homebrew
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
#### Update existing packages
```
brew update && brew upgrade
```
#### Install new packages
```
[[ ! $(command -v zsh) ]] && brew install -q zsh
[[ ! $(command -v git) ]] && brew install -q git
[[ ! $(command -v vim) ]] && brew install -q vim
[[ ! $(command -v tmux) ]] && brew install -q tmux
[[ ! $(command -v rg) ]] && brew install -q ripgrep
[[ ! $(command -v rsync) ]] && brew install -q rsync
```
#### Clean up
```
brew cleanup
```

## 2. Install dotfiles
```
git clone https://github.com/james-wei/dotfiles.git "${HOME}/co/dotfiles"
${HOME}/co/dotfiles/install
```

## 3. Change shell to ZSH
```
[[ $(command -v zsh) ]] && chsh -s $(command -v zsh)
```

## 4. Set up extra tools

### [FZF](https://github.com/junegunn/fzf)
```
git clone https://github.com/junegunn/fzf.git "${HOME}/co/fzf"
${HOME}/co/fzf/install --bin
```

### [SCM Breeze](https://github.com/scmbreeze/scm_breeze)
```
git clone git://github.com/scmbreeze/scm_breeze.git "${HOME}/co/scm-breeze"
source ${HOME}/co/scm-breeze/lib/scm_breeze.sh && _create_or_patch_scmbrc
```
