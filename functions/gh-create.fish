# creates a git repo from the current directory,
# optional parameter for the name of the repo
function gh-create
    set repo_name $argv[1]
    if test -n "$repo_name"
        gh repo create $repo_name --private --source=. --remote=origin
    else
        gh repo create --private --source=. --remote=origin
    end
    git push -u --all
    gh browse
end
