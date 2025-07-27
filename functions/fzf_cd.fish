function fzf_cd
    set -l zoxide_results (zoxide query -l)
    set -l fzf_display_paths

    for path in $zoxide_results
        set -a fzf_display_paths (string replace "$HOME" "~" "$path")
    end

    set -l selected_display_path (printf '%s\n' $fzf_display_paths | fzf)
    if test -n "$selected_display_path"
        set -l full_selected_dir (string replace "~" "$HOME" "$selected_display_path")
        set full_selected_dir (realpath "$full_selected_dir")
        __zoxide_cd "$full_selected_dir"
        if contains -- --edit $argv
            nvim -c "lua require('persistence').load()"
        end
    end
    restore
end
