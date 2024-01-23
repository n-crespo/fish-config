function fish_prompt
    if test $PWD = $HOME
        echo -n (set_color green)"~ "
    else
        echo -n (set_color green)(prompt_pwd)(set_color blue)(fish_git_prompt)
        set_color normal
    end
    echo -n (set_color green)" → "
    set_color normal
end
