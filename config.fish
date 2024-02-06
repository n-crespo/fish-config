if status is-interactive
    # Commands to run in interactive sessions can go here
end

begin
    set --local AUTOJUMP_PATH $HOME/.autojump/share/autojump/autojump.fish
    if test -e $AUTOJUMP_PATH
        source $AUTOJUMP_PATH
    end
end


# don't show time on right side
function fish_right_prompt
    #intentionally left blank
end

# don't show vi mode indicator
function fish_mode_prompt
end

# don't show greeting
set fish_greeting

# set correct editor
set -Ux EDITOR nvim
set -gx EDITOR nvim

set -Ux FZF_DEFAULT_OPTS "--height 100% --no-preview "

# fix vscode
set -x DISPLAY :0
set -x RANGER_DEVICONS_SEPARATOR " "

# add cmd.exe to path
set -x PATH $PATH /mnt/c/WINDOWS/system32

# #2bbac5
set pure_color_primary 34e2e2
# #8ae234
set pure_color_success 8ae234
# #4e9a06
set pure_color_info 4e9a06
# #4e9a06
set pure_color_mute 4e9a06


set --global hydro_symbol_prompt '→'
set --global hydro_symbol_git_dirty '*'
set --global fish_prompt_pwd_dir_length 100
# set --global hydro_color_pwd


set pure_enable_single_line_prompt true
set pure_begin_prompt_with_current_directory true
set pure_separate_prompt_on_error false
set pure_show_prefix_root_prompt true
set pure_threshold_command_duration 5
set pure_symbol_prompt '→'
set pure_symbol_git_unpulled_commits '↓'
set pure_symbol_git_unpushed_commits '↑'
set pure_symbol_git_stash ' '
set pure_symbol_reverse_prompt '→'
set pure_reverse_prompt_symbol_in_vimode true
set pure_check_for_new_release false
set pure_show_subsecond_command_duration false


function s
    eval (ssh-agent -c)
    ssh-add ~/.ssh/usernicolas
end

function mdtodocx
    pandoc -o output.docx -f markdown -t docx $argv[1].md
end

function nn
    nb $argv[1]:
    cd ~/.nb/$argv[1]
end

function rcpp
    g++ -o $argv[1] $argv[1].cpp; and ./$argv[1]
end

function rjava
    javac $argv[1].java; and java $argv[1]
end



alias lg lazygit

function g:
    git add .
    git commit -m "$argv"
    git push
end

alias gs 'git status'
alias so 'omf reload'

alias ebrc 'nvim ~/.bashrc'
alias cp 'cp -i'
alias mv 'mv -i'
alias rm 'trash -v'
alias mkdir 'mkdir -p'
alias psa 'ps auxf'
alias ping 'ping -c 10'
alias home 'cd '
alias .. 'cd ..'
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'

# maintaining dotfiles
alias dots 'echo "bash, zsh, pwsh"'
alias dotbash 'nvim -d /root/.bashrc ~/dot-files/bash/.bashrc'
alias dotzsh 'nvim -d /root/.zshrc ~/dot-files/zsh/.zshrc'
alias dotpwsh 'nvim -d /mnt/c/Users/nicol/'

# Alias's for multiple directory listing commands
# alias ls 'ls -aFh --color always' # add colors and file type extensions
alias ls 'eza --icons=always --group-directories-first' # add colors and file type extensions
alias la 'ls -Alh --group-directories-first' # show hidden files
alias lt 'ls --tree'

alias lw 'ls -xAh' # wide listing format
alias ll 'ls -l' # long listing format

# Search running processes
alias p "ps aux | grep "

# Search files in the current folder
alias f "find . | grep "

# Alias's to show disk space and space used in a folder
alias tree 'ls -T'

# jump to neovim config
alias c 'cd ~/.config/nvim;nvim init.lua'
alias cs 'cd ~/grade-12/cs/'
alias csa 'cd ~/grade-12/csa/'
# wsl specific, open explorer in cwd
alias exp 'wopen .'
alias shutdown '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -c wsl --shutdown'
alias l 'ls -l --group-directories-first'
alias ctheme 'echo "$OMB_THEME_RANDOM_SELECTED"'
alias nala 'sudo nala'
alias wopen wsl-open
alias su 'su -'
alias csv csvlens

abbr cat bat
abbr cls clear
abbr n. 'nvim .'
abbr img 'wezterm imgcat'
abbr v vim
abbr g git
abbr q exit
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
abbr sl ls
abbr dc cd
abbr weather 'curl wttr.in'
abbr ra ranger
abbr n nvim

# set -Ux LD_LIBRARY_PATH /usr/lib/jvm/java-1.11.0-openjdk-amd64/lib/server $LD_LIBRARY_PATH
set -Ux LD_LIBRARY_PATH /usr/lib/jvm/java-1.11.0-openjdk-amd64/lib/server $LD_LIBRARY_PATH
set -U fish_user_paths /home/nicolas/.cargo/bin $fish_user_paths

set parent_process (ps -o ppid= -p $fish_pid)
set parent_process (string trim $parent_process)
set parent_process (ps -o comm -p $parent_process | tail -n +2 | grep -v '^$')
# echo $parent_process

if test "$parent_process" = su
    pkill ssh
    s >/dev/null 2>&1
    echo "ssh-key added!"
end
