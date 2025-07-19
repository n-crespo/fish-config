function tt
    read -P "ticktask title: " title
    if test -z "$title"
        echo "No title entered"
        return 1
    end

    read -P "ticktask description: " desc

    echo "$desc" | ticktask $title
    set tt_status $status

    if test $tt_status -eq 0
        echo "Success!"
    else
        echo "Failed to add task :("
    end
end
