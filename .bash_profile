# include env file
if [ -f $HOME/.shell_env ]; then
  . $HOME/.shell_env

  echo $VENV_ACTIVATE_PATH
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

# Parse my git branch and add it to my prompt
function parse_git_branch {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "("${ref#refs/heads/}")"
}
export PS1='\h:\[\e[32m\]\w\e[0m\] \u \e[0;31m\]$(parse_git_branch)\e[0m\] \n \t $ '

alias ll="ls -AlFh"
