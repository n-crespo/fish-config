function fzf_insert
    set selected_file (fd --type f --exclude .git --hidden | fzf --ansi --height=50% --layout=reverse)
    if test -n "$selected_file"
        commandline -i "$selected_file"
    end
    commandline -f repaint
end
