if status is-interactive # Commands to run in interactive sessions can go here
end

printf '\e[6 q' # fix cursor on source
if test -f ~/secrets.fish
    source ~/secrets.fish
end

# env things
set -Ux EDITOR nvim # set correct editor
set -gx EDITOR nvim # set correct editor
set -Ux NVIM_FULL_CONFIG 1
set -x DISPLAY :0 # fix vscode
set fish_prompt_pwd_dir_length 52 # abbreviate paths in prompt
set -Ux FZF_DEFAULT_OPTS "--style=minimal --info=inline --height=~50% --reverse"
set -Ux _ZO_FZF_OPTS "--style=minimal --info=inline --height=~50% --reverse"
set -Ux FZF_DEFAULT_COMMAND "fd --type f --hidden --exclude .git --exclude .venv"
set -Ux LANG en_US.UTF-8
set -Ux LC_ALL en_US.UTF-8
set -Ux MANPAGER "nvim +Man!"

# prompt things
set --global fish_prompt_pwd_dir_length 100
set pure_enable_single_line_prompt true
set -g async_prompt_functions _pure_prompt_git
set pure_color_primary blue
set pure_color_success purple
set pure_color_info brblack
set pure_color_mute brblack
set pure_color_warning brblack
set pure_symbol_git_stash ''
set pure_symbol_color brpurple
set pure_show_jobs true
set pure_show_subsecond_command_duration true
set --universal pure_check_for_new_release false

# set -Ux fish_user_paths $fish_user_paths $HOME/.local/bin
fish_add_path $HOME/.local/bin

# add brew to path
if test -f /home/linuxbrew/.linuxbrew/bin/brew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end
if test -d "$(brew --prefix)/opt/openjdk@17/bin"
    fish_add_path $(brew --prefix)/opt/openjdk@17/bin
end

fzf --fish | source
# source "$HOME/.cargo/env"
zoxide init --cmd j fish | source # zoxide with j as alias

abbr lg lazygit
abbr v vim
abbr g git
abbr q exit
abbr sl ls
abbr dc cd
abbr weather 'curl wttr.in'
abbr ff fastfetch
abbr c clear
abbr n. "nvim ."
abbr n nvim

alias cp 'cp -i'
alias mv 'mv -i'
alias rm 'trash -v'
alias \\rm 'command rm'
alias mkdir 'mkdir -p'
alias psaa 'pstree -a'
alias psa 'ps -eo user,pid,cmd --forest ww'
alias ls 'eza --icons=always --group-directories-first' # add colors and file type extensions
alias la 'ls -Alh --group-directories-first' # show hidden files
alias l 'ls -l --group-directories-first --git -a'
alias lt 'ls --tree' # tree
alias p "ps aux | grep " # Search running processes
alias f "find . | grep " # Search files in the current folder
alias exp 'open .' # wsl specific, open explorer in cwd
alias nala 'sudo nala'
alias win "cd /mnt/c/Users/nicol/"
alias ns "nvim -c \"lua require('persistence').load()\""

# alias diskspace "du -Sh | sort -n -r"
# alias info 'info --vi-keys'
# alias g31 '/usr/bin/g++-10 *.cpp -std=c++17 -Wall -Wextra -Wno-sign-compare -Werror=return-type -fsanitize=address -fsanitize=undefined -fsanitize=bounds -fno-omit-frame-pointer -o /tmp/a.out && /tmp/a.out'
# alias nc "alias nc='NVIM_APPNAME=connor-nvim/ nvim'"
# alias wintop 'win --c "btop"'
# alias vim nvim

# To stop (base) in shell prompt, use `conda config --set auto_activate_base false`
## >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# if test -f /home/nicolas/miniconda3/bin/conda
#     eval /home/nicolas/miniconda3/bin/conda "shell.fish" hook $argv | source
# else
#     if test -f "/home/nicolas/miniconda3/etc/fish/conf.d/conda.fish"
#         . "/home/nicolas/miniconda3/etc/fish/conf.d/conda.fish"
#     else
#         set -x PATH /home/nicolas/miniconda3/bin $PATH
#     end
# end
## <<< conda initialize <<<

# set -Ux LD_LIBRARY_PATH "$HOME/.linuxbrew/opt/glibc/lib"
set SHELL /usr/bin/zsh
# /home/linuxbrew/.linuxbrew/opt/openjdk@17/include
# set -gx LDFLAGS "-L/home/linuxbrew/.linuxbrew/opt/glibc/lib"
# set -Ux LD_LIBRARY_PATH /usr/lib
# set -gx CPPFLAGS "-I/home/linuxbrew/.linuxbrew/opt/glibc/include"
# set -Ux LDFLAGS "-L/home/linuxbrew/.linuxbrew/opt/glibc/lib"
# set -Ux CPPFLAGS "-I/home/linuxbrew/.linuxbrew/opt/glibc/include"
# set -gx CPPFLAGS "-I/home/linuxbrew/.linuxbrew/opt/openjdk@17/include"
