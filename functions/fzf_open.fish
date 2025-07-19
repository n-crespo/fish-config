function fzf_open
    set selected_file (fd --type f --exclude .git --hidden --no-ignore | fzf --ansi --height=50% --layout=reverse)
    if test -n "$selected_file"
        nvim "$selected_file"
    end
    restore
end
