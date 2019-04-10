# Setting the path for mysql
PATH="/usr/local/bin/mysql:${PATH}"
export PATH

# Adds the paleo repo to PYTHONPATH
PYTHONPATH="/Users/joeswanson/spark/paleo:${PYTHONPATH}"
export PYTHONPATH

# Alias to sfe.py
alias sfe="/Users/joeswanson/spark/paleo/sfe.py"
alias ll="ls -AlFh"
alias cds="cd /var/www"
alias log="sudo tailf /var/log/nginx/error.log"

# Parse my git branch and add it to my prompt
function parse_git_branch {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "("${ref#refs/heads/}")"
}
export PS1='\h:\[\e[32m\]\w\e[0m\] \u \e[0;31m\]$(parse_git_branch)\e[0m\] \n \t $ '

alias dev='ssh -A joe@10.255.198.40'
alias mountdev='sshfs joe@joe-dev:/var/spork/sparkfun /users/joeswanson/mnt/joe-dev'
alias mountcasper='sshfs joe@joe-dev:/var/spork/sparkfun/tests/integration/captures /users/joeswanson/mnt/casper'

SPARK_DIR="/Users/joeswanson/spark/paleo"
alias cds='cd $SPARK_DIR && source paleo_env/bin/activate'

alias ll='ls -AlFh'
alias settings='vim /users/joeswanson/spark/paleo/sfe/settings.py'

# A jq command to clean up superfluous jupyter notebook data (for use with git to make notebooks friendlier)
alias nbstrip_jq="jq --indent 1 \
    '(.cells[] | select(has(\"outputs\")) | .outputs) = [] \
    | (.cells[] | select(has(\"execution_count\")) | .execution_count) = null  \
    | .metadata = {\"language_info\": {\"name\": \"python\", \"pygments_lexer\": \"ipython3\"}} \
    | .cells[].metadata = {} \
    '"
