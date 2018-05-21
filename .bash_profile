# Setting the path for mysql
PATH="/usr/local/bin/mysql:${PATH}"
export PATH

# Setting PATH for EPD_free-7.3-2
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
export PATH

# Adds the paleo repo to PYTHONPATH
PYTHONPATH="/Users/joeswanson/spark/paleo:${PYTHONPATH}"
export PYTHONPATH

# Alias to sfe.py
alias sfe="/Users/joeswanson/spark/paleo/sfe.py"
alias ll="ls -AlFh"
alias cds="cd /var/www"
alias log="sudo tailf /var/log/nginx/error.log"

function parse_git_branch {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "("${ref#refs/heads/}")"
}

export PS1='\h:\[\e[32m\]\w\e[0m\] \u \e[0;31m\]$(parse_git_branch)\e[0m\] \n \t $ '
