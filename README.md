# Joe's Home Directory

This is my spot for keeping my dotfiles so that I can quickly clone them if I need to set
up a new machine.

This file contains rc files for both bash and zsh, which rely on a local file called `.shell_env`
where all machine-specific variables can be declared. This file should also include any PATH
settings. Both of the rc files will load the `.shell_env` file if it exists on the machine,
and set aliases according to the variables included in `.shell_env`. Machine-secific aliases should
also be defined in this file.

Here is a list of the variables that these rc files look for when defining aliases:
```
WORKING_DIR
LOG_DIR
IRC_SERVER
IRC_USER
DEV_SERVER
DEV_USER
VENV_ACTIVATE_PATH
SETTINGS_DIR
```

## Cloning into Home
    cd
    git init
    git remote add origin git@github.com:joescottswanson/home.git
    git fetch
    git branch master origin/master
    git checkout master
