function fish_title \
    --description "Set title to current folder, with command unless it's fish or idle" \
    --argument-names last_command

    # Get the current folder name (always show this)
    set --local current_folder (prompt_pwd)

    # Get the currently executing command.
    # This will be empty if no command is actively executing (idle prompt).
    set --local current_running_command (status current-command)

    # Determine what to display after the folder
    set --local title_suffix

    if test -n "$current_running_command" -a "$current_running_command" != fish
        # If a command is running AND it's not "fish" itself, show that command
        set title_suffix "$current_running_command"
        echo "$current_folder: $title_suffix"
    else
        echo "$current_folder"
    end
end
