if status is-interactive
    # Commands to run in interactive sessions can go here
end

# ----------------------- #
#       VARIABLES
# ----------------------- #

# set -e fish_user_paths
set -e fish_user_paths
set -Ux fish_user_paths $fish_user_paths /home/nicolas/julia-1.8.1/bin /home/nicolas/.cargo/bin/ /user/lib/jvm/java-1.11.0-openjdk-amd64/lib/server
set -Ux EDITOR nvim # set correct editor
set -Ux JAVA_HOME /usr/lib/jvm/jdk-17-oracle-x64
set -gx EDITOR nvim # set correct editor
set -Ux FZF_DEFAULT_OPTS "--height 100% --no-preview "
set -x DISPLAY :0 # fix vscode
set -x RANGER_DEVICONS_SEPARATOR " "
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv) # some brew stuff
set fish_prompt_pwd_dir_length 0 # don't abbreviate paths in prompt
set -Ux FZF_FIND_FILE_COMMAND "find . -type d -name .git -prune -o -type f -print"
set -Ux FZF_OPEN_COMMAND "fd --type f --exclude .git --hidden"
zoxide init --cmd j fish | source # zoxide

# ----------------------- #
#       FUNCTIONS
# ----------------------- #

function fish_greeting
    # fortune
end

function fish_right_prompt
    # don't show time on right side
end

function fish_mode_prompt
    # don't show vi mode indicator
end

function s
    eval (ssh-agent -c)
    ssh-add ~/.ssh/usernicolas
end

function mdtodocx
    pandoc -o output.docx -f markdown -t docx $argv[1].md
end

# function rcpp
#     g++ -o $argv[1] $argv[1].cpp; and ./$argv[1]
# end

function rcpp
    g++ -o main *.cpp && ./main
end

function imgview
    kitty +kitten icat $argv[1]
end

function rjava
    javac $argv[1].java; and java $argv[1]
end

function g:
    git add .
    git commit -m "$argv"
    git push
end

# # add ssh-key if shell is opened on startup, not in random shell instances
set parent_process (ps -o ppid= -p $fish_pid)
set parent_process (string trim $parent_process)
set parent_process (ps -o comm -p $parent_process | tail -n +2 | grep -v '^$')
if test "$parent_process" = su
    s >/dev/null 2>&1
    echo "ssh-key added!"
end

# ----------------------- #
#        ALIASES
# ----------------------- #

alias gs 'git status'
alias so 'omf reload'
alias cp 'cp -i'
alias mv 'mv -i'
alias rm 'trash -v'
alias mkdir 'mkdir -p'
alias psa 'ps auxf'
alias ping 'ping -c 10'
alias .. 'cd ..'
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias ls 'eza --icons=always --group-directories-first' # add colors and file type extensions
alias la 'ls -Alh --group-directories-first' # show hidden files
alias l 'ls -l --group-directories-first'
alias lt 'ls --tree' # tree
alias p "ps aux | grep " # Search running processes
alias f "find . | grep " # Search files in the current folder
alias cs 'cd ~/grade-12/cs/'
alias csa 'cd ~/grade-12/csa/'
alias exp 'wopen .' # wsl specific, open explorer in cwd
alias shutdown '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -c wsl --shutdown'
alias nala 'sudo nala'
alias wopen wsl-open
alias su 'su -'
alias csv csvlens
alias rmm dos2unix
alias cmd.exe /mnt/c/Windows/System32/cmd.exe
alias nn /usr/bin/nvim

# ----------------------- #
#     ABBREVIATIONS
# ----------------------- #

abbr cat bat
abbr cls clear
abbr lg lazygit
abbr n. 'nvim .'
abbr img 'wezterm imgcat'
abbr v vim
abbr g git
abbr q exit
abbr sl ls
abbr dc cd
abbr weather 'curl wttr.in'
abbr ra ranger
abbr n nvim
