# copy_cmds=("pwd" "cat")

alias pwdc="pwd | tee >(pbcopy)"

for cmd in "${copy_cmds[@]}"; do
  # alias $cmd="$cmd | tee >(pbcopy)"
done
