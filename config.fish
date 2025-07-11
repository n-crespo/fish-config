if status is-interactive
    # Commands to run in interactive sessions can go here
end

# if test -f ~/.env
#     for line in (cat ~/.env)
#         set key_value (string split "=" $line)
#         set -x $key_value[1] $key_value[2]
#     end
# end

# ----------------------- #
#       VARIABLES
# ----------------------- #

set -Ux NVIM_FULL_CONFIG 1
# set -e fish_user_paths

if test -f /home/linuxbrew/.linuxbrew/bin/brew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv) # some brew stuff
end

if test -d /home/nicolas/.local/bin
    set -Ux fish_user_paths $fish_user_paths /home/nicolas/.local/bin
end
# /home/linuxbrew/.linuxbrew/opt/openjdk@17/include
# set -Ux LD_LIBRARY_PATH "$HOME/.linuxbrew/opt/glibc/lib"
# set -gx LDFLAGS "-L/home/linuxbrew/.linuxbrew/opt/glibc/lib"
# set -Ux LD_LIBRARY_PATH /usr/lib
# set -gx CPPFLAGS "-I/home/linuxbrew/.linuxbrew/opt/glibc/include"
# set -Ux LDFLAGS "-L/home/linuxbrew/.linuxbrew/opt/glibc/lib"
# set -Ux CPPFLAGS "-I/home/linuxbrew/.linuxbrew/opt/glibc/include"

set -Ux EDITOR nvim # set correct editor
set -gx EDITOR nvim # set correct editor
set -x DISPLAY :0 # fix vscode
set fish_prompt_pwd_dir_length 52 # abbreviate paths in prompt
set -Ux FZF_DEFAULT_OPTS "--border --info=inline --height=50%"
set -Ux FZF_DEFAULT_COMMAND "fd --type f --hidden --exclude .git --exclude .venv"
# set SHELL /usr/bin/zsh
set -Ux LANG en_US.UTF-8
set -Ux LC_ALL en_US.UTF-8
# set -Ux LC_CTYPE C.UTF-8
export MANPAGER="nvim +Man!"

zoxide init --cmd j fish | source # zoxide with j as alias

set --global fish_prompt_pwd_dir_length 100

set -g async_prompt_functions _pure_prompt_git
set pure_symbol_title_bar_separator ""
set pure_shorten_window_title_current_directory_length 1
set pure_truncate_window_title_current_directory_keeps 1
set pure_color_primary blue
set pure_color_success brgreen
set pure_color_info green
set pure_color_mute green
set pure_color_warning green
set pure_check_for_new_release false
set pure_enable_single_line_prompt true
set pure_begin_prompt_with_current_directory true
set pure_separate_prompt_on_error false
set pure_show_prefix_root_prompt true
set pure_threshold_command_duration 5
set pure_enable_git true
set pure_symbol_prompt '❯'
set pure_symbol_git_unpulled_commits '↓'
set pure_symbol_git_unpushed_commits '↑'
set pure_symbol_reverse_prompt '❮'
set pure_symbol_git_stash ' '
set pure_reverse_prompt_symbol_in_vimode true
set pure_show_subsecond_command_duration false
set pure_show_jobs true

# ----------------------- #
#        ALIASES
# ----------------------- #

alias gs 'git status -s'
alias gl "git log --all --graph --pretty=format:'%C(magenta)%h %C(white) %an %ar%C(auto) %D%n%s%n'" # just use lazygit atp
alias so 'source ~/.config/fish/config.fish'
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
alias shutdown '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -c wsl --shutdown'
alias nala 'sudo nala'
alias csv csvlens
alias win "cd /mnt/c/Users/nicol/"
alias powershell.exe "/mnt/c/Users/nicol/AppData/Local/Microsoft/WindowsApps/pwsh.exe -WorkingDirectory C:/Users/nicol -nologo"
alias pwsh "/mnt/c/Users/nicol/AppData/Local/Microsoft/WindowsApps/pwsh.exe -WorkingDirectory C:/Users/nicol -nologo"
alias cmd.exe "/mnt/c/Windows/System32/cmd.exe"
alias focus 'cbonsai -i -l --time=0.1 --life=50'
alias diskspace "du -Sh | sort -n -r"
alias venv "python3 -m venv .venv;source .venv/bin/activate.fish"
alias senv "source .venv/bin/activate.fish"
alias info 'info --vi-keys'
alias ns "nvim -c \"lua require('persistence').load()\""
# alias g31 '/usr/bin/g++-10 *.cpp -std=c++17 -Wall -Wextra -Wno-sign-compare -Werror=return-type -fsanitize=address -fsanitize=undefined -fsanitize=bounds -fno-omit-frame-pointer -o /tmp/a.out && /tmp/a.out'
# alias nc "alias nc='NVIM_APPNAME=connor-nvim/ nvim'"
# alias wintop 'win --c "btop"'
# alias vim nvim

# ----------------------- #
#     ABBREVIATIONS
# ----------------------- #

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

# ----------------------- #
#       FUNCTIONS
# ----------------------- #

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

function fish_right_prompt
    # don't show time on right side
end

function fish_mode_prompt
    # don't show vi mode indicator
end

function skey
    eval (ssh-agent -c)
    ssh-add ~/.ssh/usernicolas
end

function mdtodocx
    pandoc -o output.docx -f markdown -t docx $argv[1].md
end

function rcpp
    if test (count $argv) -eq 0
        set files *.cpp
    else
        set files $argv[1]
    end
    clang++ $files -o /tmp/main && /tmp/main
end

function dcpp
    g++ -g *.cpp -o main
end

function rjava
    javac $argv[1].java -d bin/; and java -cp bin/ $argv[1]
end

function rjall
    javac *.java -d bin/; and java -cp bin/ src.Main
end

function g:
    git add .
    git commit -m "$argv"
    git push
end

function gc:
    git add .
    git commit -m "$argv"
end

function e
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        cd -- "$cwd"
    end
    /bin/rm -f -- "$tmp"
end

function notify-send
    /mnt/c/Users/nicol/OneDrive/Desktop/Applications/wsl-notify-send.exe --category $WSL_DISTRO_NAME "$argv"
end

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

function fzf_zoxide
    set preview_toggle "--preview=eza --color=always --long --no-filesize --icons=always --no-time --no-user --no-permissions {}"
    set selected_repo (zoxide query --list | fzf --ansi --height=50% --layout=reverse $preview_toggle \
        --bind "ctrl-p:toggle-preview" \
        --header "jump to directory" \
        --preview-window=hidden)
    if test -n "$selected_repo"
        cd "$selected_repo"
    end
    restore
end

# this just opens neovim at the selected directory and loads the saved session
# via persistence.nvim.
# https://github.com/n-crespo/nvim/blob/3a594a35f88f8e80beb0fd3e97a42940d6df8748/lua/plugins/persistence.lua#L18
function fzf_zoxide_nvim
    set preview_toggle "--preview=eza --color=always --long --no-filesize --icons=always --no-time --no-user --no-permissions {}"
    set selected_repo (zoxide query --list | fzf --ansi --height=50% --layout=reverse $preview_toggle \
  --bind "ctrl-p:toggle-preview" \
  --header "load nvim session at dir" \
  --preview-window=hidden)
    if test -n "$selected_repo"
        cd "$selected_repo"
        nvim -c "lua require('persistence').load()"
    end
    restore
end

function fzf_open
    set preview_toggle "--preview=bat --color=always --plain --line-range=:50 {}"
    set selected_file (fd --type f --exclude .git --hidden | fzf --ansi --height=50% --layout=reverse $preview_toggle --bind "ctrl-p:toggle-preview" --header "open selected file")
    if test -n "$selected_file"
        nvim "$selected_file"
    end
    restore
end

function fzf_history
    set selected_command (history | fzf --ansi --height=50% --bind "ctrl-p:toggle-preview")

    if test -n "$selected_command"
        commandline -r "$selected_command"
    end
    restore
end

function fzf_insert
    set preview_toggle "--preview=bat --color=always --plain --line-range=:50 {}"

    set selected_file (fd --type f --exclude .git --hidden | fzf --ansi --height=50% --layout=reverse $preview_toggle --bind "ctrl-p:toggle-preview" --header "insert selected file")
    if test -n "$selected_file"
        commandline -i "$selected_file"
    end
    commandline -f repaint
end

function restore
    commandline -f repaint
    printf '\e[6 q' # restore cursor
end

printf '\e[6 q'
function restore_cursor --on-event fish_postexec
    printf '\e[6 q' # restore cursor
end

# ----------------------- #
#       KEYBINDINGS
# ----------------------- #

bind \cz "fg;restore" # <C-z> does fg
bind \e\[13\;5u accept-autosuggestion # control-enter to accept-autosuggestion
bind \e\x7F kill-whole-line repaint # use <M-BS> for clearing line
bind \cS __fish_prepend_sudo # prepend sudo to last command with ctrl+s

# standard nav keymaps
bind \cP history-search-backward
bind \cN history-search-forward
bind \ca beginning-of-line
bind \ce end-of-line

# FZF Keymaps
bind \cj fzf_zoxide # jump to directory
bind \cf fzf_zoxide_nvim # jump to directory
bind \co fzf_open # open file
bind \cr fzf_history # search history
bind \ct fzf_insert # insert file

# NOTE: To stop (base) in shell prompt, use `conda config --set auto_activate_base false`

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

if test -f ~/secrets.fish
    source ~/secrets.fish
end
