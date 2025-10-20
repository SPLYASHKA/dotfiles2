# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# all of our zsh files
typeset -U config_files
config_files=(~/.zsh/***/*.zsh) # *** for symlinks

# TODO get out of omz
source ${(M)config_files:#*/oh-my-zsh.zsh}

# load everything but oh-my-zsh.zsh

#for file in $config_files
for file in ${config_files:#*/oh-my-zsh.zsh}
do
  source $file
done

unset config_files
