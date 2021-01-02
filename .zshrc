if [ ! -s ${HOME}/antigen.zsh ]; then
  curl -Lso ${HOME}/antigen.zsh git.io/antigen
fi
source "${HOME}/antigen.zsh"

# Load oh-my-zsh
antigen use oh-my-zsh

# Bundles: base
antigen bundle colored-man-pages
antigen bundle vi-mode
antigen bundle tmux

# Bundles: external
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# Theme: Pure (https://github.com/sindresorhus/pure)
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

antigen apply

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
FZF_DEFAULT_COMMAND='rg --files'
FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"

# SCM Breeze: https://github.com/scmbreeze/scm_breeze
if [ -s ${HOME}/co/scm-breeze/scm_breeze.sh ]; then
  source ${HOME}/co/scm-breeze/scm_breeze.sh
fi

# OS-specific configuration
if [[ "${OSTYPE}" = 'linux-gnu'* ]]; then # Linux
  # Locally compiled binaries
  [ -d "${HOME}/.local/bin" ] && export PATH="${HOME}/.local/bin:$PATH"

  # FZF
  if [ -d "${HOME}/.fzf" ]; then
    export PATH="${PATH:+${PATH}:}${HOME}/.fzf/bin"
    [[ $- == *i* ]] && source "${HOME}/.fzf/shell/completion.zsh" 2> /dev/null
    source "${HOME}/.fzf/shell/key-bindings.zsh"
  fi
elif [[ "${OSTYPE}" = 'darwin'* ]]; then # macOS
  # Homebrew binaries
  export PATH="/usr/local/bin:$PATH"
  export PATH="/usr/local/sbin:$PATH"

  # FZF via Homebrew
  if [ -d "/usr/local/opt/fzf" ]; then
    [[ $- == *i* ]] && source '/usr/local/opt/fzf/shell/completion.zsh' 2> /dev/null
    source '/usr/local/opt/fzf/shell/key-bindings.zsh' 2> /dev/null
  fi
else
  echo 'Warning: unrecognized operating system'
fi

# Aliases
alias editshconfig='vim ~/.zshrc'
alias gplr='git pull --rebase origin main'
alias j='cd ${HOME} && clear'
alias reattach='tmux attach -t main'
alias reloadshconfig='source ~/.zshrc'
alias startmux='tmux new -s main'

# Functions
function f() { rg -i -p "$1" | less -R -S }
function fixtrailingspaces() { sed -i 's/[[:space:]]*$//' "$1" }
function vigsh() { vim -p $(git show --name-only --format='' | grep '\S') }
function vimod() { vim -p $(git status --porcelain | awk '{print $2}') }
