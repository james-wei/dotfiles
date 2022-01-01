if [ ! -s ${HOME}/antigen.zsh ]; then
  curl -Lso ${HOME}/antigen.zsh git.io/antigen
fi
source "${HOME}/antigen.zsh"

# Load oh-my-zsh
antigen use oh-my-zsh

# Bundles: base
antigen bundle colored-man-pages
antigen bundle tmux

# Bundles: external
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# Theme: Pure (https://github.com/sindresorhus/pure)
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure --branch=main

antigen apply

# Set Git checkouts directory
CHECKOUTS="${HOME}/co"
mkdir -p "${CHECKOUTS}"

# Set colors
if [ -s ${HOME}/.vim/plugged/gruvbox/gruvbox_256palette.sh ]; then
  source ${HOME}/.vim/plugged/gruvbox/gruvbox_256palette.sh
fi

# Pure theme customizations
# Disable execution time display
PURE_CMD_MAX_EXEC_TIME=1048576
# Single-line prompt: github.com/sindresorhus/pure/issues/228
prompt_newline='%666v'
PROMPT=" $PROMPT"
# Higher contrast colors
zstyle :prompt:pure:git:branch color 208
zstyle :prompt:pure:git:action color 136
zstyle :prompt:pure:git:dirty color 170
zstyle :prompt:pure:path color 39
zstyle :prompt:pure:prompt:success color 198

# FZF: https://github.com/junegunn/fzf
if [ -d ${CHECKOUTS}/fzf ]; then
  FZF_DEFAULT_COMMAND='rg --files'
  FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
  export PATH="${PATH:+${PATH}:}${CHECKOUTS}/fzf/bin"
  [[ $- == *i* ]] && source "${CHECKOUTS}/fzf/shell/completion.zsh" 2> /dev/null
  source "${CHECKOUTS}/fzf/shell/key-bindings.zsh"
fi

# SCM Breeze: https://github.com/scmbreeze/scm_breeze
if [ -s ${CHECKOUTS}/scm-breeze/scm_breeze.sh ]; then
  source ${CHECKOUTS}/scm-breeze/scm_breeze.sh
fi

# Vi mode
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins 'JK' vi-cmd-mode

# OS-specific configuration
if [[ $(uname -s) = 'Linux' ]]; then # Linux
  # Locally compiled binaries
  [ -d "${HOME}/.local/bin" ] && export PATH="${HOME}/.local/bin:$PATH"
elif [[ $(uname -s) = 'Darwin' ]]; then # macOS
  # Homebrew binaries
  export PATH="/usr/local/bin:$PATH"
  export PATH="/usr/local/sbin:$PATH"
else
  echo 'Warning: unrecognized operating system'
fi

# Aliases
alias editshconfig='vim ~/.zshrc'
alias j='cd ${HOME} && clear'
alias reattach='tmux attach -t main'
alias reloadshconfig='source ~/.zshrc'
alias startmux='tmux new -s main'

# Functions
function f() { rg -i -p "$1" | less -R -S }
function fixtrailingspaces() { sed -i 's/[[:space:]]*$//' "$1" }
function gplr() {
  if git branch --list | grep "main$" &> /dev/null; then
    git pull --rebase origin main
  else
    git pull --rebase origin master
  fi
}
function vigsh() { vim -p $(git show --name-only --format='' | grep '\S') }
function vimod() { vim -p $(git status --porcelain | awk '{print $2}') }
