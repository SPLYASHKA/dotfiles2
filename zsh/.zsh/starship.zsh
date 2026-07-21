command -v starship &> /dev/null || curl -sS https://starship.rs/install.sh | sh
eval "$(starship init zsh)"
