function fish_title \
    --description "Set title to current folder and shell name" \
    --argument-names last_command

    set --local current_folder (basename (pwd))

    set --local prompt "$current_folder"

    echo $prompt
end
