# load in git branch info
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info; }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:git:*' formats '%F{red}(%b)%f'
zstyle ':vcs_info:*' enable git

# load up git tab completion for zsh
autoload -Uz compinit && compinit

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT="%m:%F{green}%~%f %n \$vcs_info_msg_0_"$'\n'" %* $ "

alias ll="ls -AlFh"

# set up autojump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# track history in a file
export HISTFILE=~/.zsh_history

# make it keep track of a lot of history
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000

# append the file immediately after entering a command (instead of waiting until the shell closes)
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "

# adds a timestamp to history
setopt EXTENDED_HISTORY

# get rid of duplicate entries
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

# vim motions
bindkey -v

# adds an alias dt to generate a timestamp and copy it to the clipboard
alias dt='date -u +%Y%m%d%H%M%S | pbcopy'


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PYTHONPATH="${PYTHONPATH}:/Users/joeswanson/campspot/db-connections"
export PATH=$HOME/campspot/release-builder/bin:$PATH
export PATH=$HOME/campspot/easy-report-runner/bin:$PATH
export PATH=$HOME/.tgenv/bin:$PATH


export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

alias mk="minikube kubectl --"

source ~/campspot/campspot-utility-scripts/ssh-utilities.sh
eval "$(/opt/homebrew/bin/brew shellenv)"
# Set the PYENV_ROOT variable to point to the location of Pyenv
export PYENV_ROOT="$HOME/.pyenv"
 
# Check if pyenv command is available, if not, add Pyenv binary directory to PATH
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
#
# Initialize pyenv into the shell session
eval "$(pyenv init -)"
 

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# opensearch
export PATH=/Library/Java/JavaVirtualMachines/graalvm-ce-java11-22.3.1/Contents/Home/bin:"$PATH"

# Setting PATH for Python 2.7
# The original version is saved in .zprofile.pysave
# I don't know why this line is here. Commenting it out because it's cramping my python style.
# PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
# export PATH
alias mk="minikube kubectl --"

. "$HOME/.local/bin/env"

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# set neovim as my editor
export EDITOR=nvim

#
# include env file
if [ -f $HOME/.shell_env ]; then
  . $HOME/.shell_env
  # set up cds alias to change dirs to project root and maybe activate a venv if VENV_ACTIVATE_PATH is set
  if [ -n "$VENV_ACTIVATE_PATH" ]; then
    alias cds="cd $WORKING_DIR && source $VENV_ACTIVATE_PATH"
  else
    alias cds="cd $WORKING_DIR"
  fi

  # set up alias log to tail a log file if $LOG_DIR is set
  if [ -n "$LOG_DIR" ]; then
    alias log="sudo tail -f $LOG_DIR"
  fi

  # set up alias irc to use mosh to connect user $IRC_USER to an irc server if $IRC_SERVER both are set
  if [ -n "$IRC_SERVER" ] && [ -n "$IRC_USER" ]; then
    alias irc="mosh $IRC_USER@$IRC_SERVER"
  fi

  # set up alias dev to use mosh to connect user $DEV_USER to a dev server if $DEV_SERVER both are set
  if [ -n "$DEV_SERVER" ] && [ -n "$DEV_USER" ]; then
    alias dev="mosh $DEV_USER@$DEV_SERVER"
  fi

  # set up alias settings to use vim to open up a settings file if $SETTINGS_DIR is set
  if [ -n "SETTINGS_DIR" ]; then
    alias settings='vim /users/joeswanson/spark/paleo/sfe/settings.py'
  fi
fi
alias mk="minikube kubectl --"
