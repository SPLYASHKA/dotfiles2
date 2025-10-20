export ZSH="$HOME/.oh-my-zsh"

! [[ -d $ZSH ]] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc

plugins=(
    autoupdate
    zsh-autosuggestions
    zsh-syntax-highlighting
    you-should-use
    z
    git
    tldr
    man
    thefuck
    alias-finder
    aliases
    web-search
    tmux
    safe-paste
    archlinux
)
# zshplug

source $ZSH/oh-my-zsh.sh

 if [[ -n $ZSH_CUSTOM ]]; then
   ! [[ -d $ZSH_CUSTOM/plugins/autoupdate ]] && git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins $ZSH_CUSTOM/plugins/autoupdate
   ! [[ -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ]] && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
   ! [[ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
   ! [[ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/catppuccin/zsh-syntax-highlighting ]] && git clone https://github.com/catppuccin/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/catppuccin/zsh-syntax-highlighting
   ! [[ -d $ZSH_CUSTOM/plugins/you-should-use ]] && git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use
 fi

source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/catppuccin/zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh
