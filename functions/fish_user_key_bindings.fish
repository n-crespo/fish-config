function fish_user_key_bindings

    # ----------------------- #
    #       KEYBINDINGS
    # ----------------------- #

    bind \cz "fg;restore" # <C-z> does fg
    bind \e\[13\;5u accept-autosuggestion # control-enter to accept-autosuggestion
    bind \e\x7F kill-whole-line repaint # use <M-BS> for clearing line
    bind \cS __fish_prepend_sudo # prepend sudo to last command with ctrl+s

    # standard nav keymaps
    bind \cP history-search-backward
    bind \cN history-search-forward
    bind \ca beginning-of-line
    bind \ce end-of-line

    # FZF Keymaps
    bind \cj fzf_zoxide_cd # jump to directory
    bind \cf fzf_zoxide_edit # jump to directory
    bind \co fzf_open # open file
    bind \cr fzf_history # search history
    bind \ct fzf_insert # insert file

end
