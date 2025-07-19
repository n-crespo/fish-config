function fzf_history
    set selected_command (history | fzf --ansi --height=50% --reverse)
    if test -n "$selected_command"
        commandline -r "$selected_command"
    end
    restore
end
