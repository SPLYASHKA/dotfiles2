alias zshrc='vim ~/.zshrc'
alias zshplug='vim +/zshplug ~/.zshrc'
alias zshals='vim "$DOTFILES/old_zsh/.zsh/aliases.zsh"'
alias dotf='cd $DOTFILES'
alias vimrc='vim ~/.vimrc'

alias vin='vim --clean'

alias rm='rm -r'
alias scp='scp -r'
alias cp='cp -r'
alias md='mkdir -p'

alias tra='tree -a'

alias icat='kitty +kitten icat'

alias fzfi='fzf --preview "viu {}"'
alias fzfb='fzf --preview "viu -b {}"'

alias vimf='vim "$(fzf)"'

alias stdcon='pbpaste | ./a.out | cowsay -nf tux'
alias sclang='clang++ -std=c++20 -fsanitize=address,undefined -g -Wall -Wextra -pedantic -Werror -Wno-self-assign-overloaded -Wno-missing-braces'
