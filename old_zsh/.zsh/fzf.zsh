# export FZF_DEFAULT_OPTS=" \
# --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
# --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
# --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
# --ansi \
# --preview 'bat --color=always {}'"
export FZF_DEFAULT_COMMAND="fd --type file --hidden --exclude .git"
# тут не будут искаться файлы из gitignore, fd по дефолту игнорит
export FZF_DEFAULT_OPTS_FILE=~/.fzfrc
export FZF_CTRL_T_COMMAND="fd --type file --hidden --exclude .git"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

export FZF_LAYOUT_BOTTOM=(--height ${FZF_TMUX_HEIGHT:-40%} --min-height 20+ --reverse)
