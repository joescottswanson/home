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

# load in git branch info
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:git:*' formats '%F{red}(%b)%f'
zstyle ':vcs_info:*' enable git

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT="%m:%F{green}%~%f %n \$vcs_info_msg_0_"$'\n'" %* $ "

alias ll="ls -AlFh"
