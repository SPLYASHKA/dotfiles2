bindkey -v
bindkey -M viins 'jj' vi-cmd-mode

my_nvim_func() {
    BUFFER="nvim"
    zle accept-line

}
zle -N my_nvim_func
bindkey '^N' my_nvim_func
