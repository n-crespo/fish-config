function fzf_jump
    set -l selected_dir (zoxide query -l | string replace -r "^$HOME" "~" | fzf)
    if test -n "$selected_dir"
        set selected_dir (string replace -r "^~" "$HOME" "$selected_dir")
        cd "$selected_dir"
        if set -q _flag_nvim
            nvim -c "lua require('persistence').load()"
        end
    end
    restore
end
