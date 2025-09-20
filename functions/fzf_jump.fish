function fzf_jump
    set -l selected_dir (zoxide query -l | string replace -r "^$HOME/" "~/" | string replace -r "^/mnt/c[/]?" "WIN: " | fzf)
    if test -n "$selected_dir"
        set selected_dir (string replace -r "^~" "$HOME" "$selected_dir")
        set selected_dir (string replace -r "^WIN: " "/mnt/c/" "$selected_dir")
        if string match -q "/*" -- $selected_dir
            cd "$selected_dir"
        else
            cd "$HOME/$selected_dir"
        end
        if contains -- --edit $argv
            nvim -c "lua require('persistence').load()"
        end
    end
    restore
end
