function fzf_zoxide_cd
    set -l selected_dir (command zoxide query --interactive)
    if test -n "$selected_dir"
        __zoxide_cd "$selected_dir"
        if contains -- --edit $argv
            nvim -c "lua require('persistence').load()"
        end
        restore
    end
end
