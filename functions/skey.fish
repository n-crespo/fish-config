function skey
    eval (ssh-agent -c)
    ssh-add ~/.ssh/usernicolas
end
