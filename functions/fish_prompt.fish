function fish_prompt
    # if test $PWD = $HOME
    #     echo -n (set_color green)"~ "
    # else
    # end
    echo -n (set_color 89ca78)(prompt_pwd)
    echo -n (set_color 61afef)"  "
    set_color normal
end
