function fish_prompt
    # if test $PWD = $HOME
    #     echo -n (set_color green)"~ "
    # else
    # end
    echo -n (set_color green)(prompt_pwd)
    echo -n (set_color blue)"  "
    set_color normal
end
