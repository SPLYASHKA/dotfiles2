# zmodload zsh/zprof
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

eval "$(zoxide init zsh)"
# all of our zsh files
typeset -U config_files
config_files=(~/.zsh/***/*.zsh) # *** for symlinks

for file in $config_files
do
  source $file
done

unset config_files

eval "$(sheldon source)"

fortune | cowsay -f tux
# zprof
