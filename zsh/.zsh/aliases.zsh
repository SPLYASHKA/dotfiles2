alias zshrc='vim ~/.zshrc'
alias zshals='nvim "$DOTFILES/old_zsh/.zsh/aliases.zsh"'
alias dotf='cd $DOTFILES'
alias zet='cd $TESTIUM/Zettelkasten/'
alias day='cd $TESTIUM/Daily/'
alias vimrc='vim ~/.vimrc'

alias vin='vim --clean'
alias nvin='nvim --clean'
alias nvimdiff='nvim -d'

alias rm='rm -r'
alias scp='scp -r'
alias cp='cp -r'
alias md='mkdir -p'

alias tra='tree -a -I ".git"'

alias icat='kitty +kitten icat'

alias vimf='vim "$(fzf)"'
alias nf='fzf --bind '\''enter:become(nvim {})'\'' --preview="bat -n --color=always {}" ${FZF_LAYOUT_BOTTOM[@]}'

alias stdcon='pbpaste | ./a.out | cowsay -nf tux'
alias sclang='clang++ -std=c++20 -fsanitize=address,undefined -g -Wall -Wextra -pedantic -Werror -Wno-self-assign-overloaded -Wno-missing-braces'

alias lman='gman -M ~/Downloads/man-pages-6.16'
