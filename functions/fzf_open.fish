function fzf_open
    set -l selected_file (fd --type f --exclude .git --hidden --no-ignore | fzf)
    if test -n "$selected_file"
        nvim "$selected_file"
    end
    restore
end
