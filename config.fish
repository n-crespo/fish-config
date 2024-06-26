if status is-interactive
    # Commands to run in interactive sessions can go here
end

# ----------------------- #
#       VARIABLES
# ----------------------- #

# set -e fish_user_paths
set -e fish_user_paths
set -Ux fish_user_paths $fish_user_paths /home/nicolas/julia-1.8.1/bin /home/nicolas/.cargo/bin/ /user/lib/jvm/java-1.11.0-openjdk-amd64/lib/server
set -g async_prompt_functions _pure_prompt_git

set -Ux EDITOR /usr/bin/nvim # set correct editor
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
theme_tokyonight storm

# # #2bbac5
set pure_color_primary 34e2e2
# # #8ae234
set pure_color_success 8ae234
# # #4e9a06
set pure_color_info 4e9a06
# # #4e9a06
set pure_color_mute 4e9a06

# set --global hydro_symbol_prompt '→'
set --global hydro_symbol_git_dirty '*'
set --global fish_prompt_pwd_dir_length 100
# set --global hydro_color_pwd

set pure_color_warning green

set pure_enable_single_line_prompt true
set pure_begin_prompt_with_current_directory true
set pure_separate_prompt_on_error false
set pure_show_prefix_root_prompt true
set pure_threshold_command_duration 5
set pure_symbol_prompt '❯'
set pure_enable_git true # this can be disable to make things faster but async does that too
set pure_symbol_git_unpulled_commits '↓'
set pure_symbol_git_unpushed_commits '↑'
set pure_symbol_git_stash ' '
set pure_symbol_reverse_prompt '❯'
set pure_symbol_reverse_prompt '❮'
set pure_reverse_prompt_symbol_in_vimode true
set pure_check_for_new_release false
set pure_show_subsecond_command_duration false
set pure_show_jobs true
set lucid_skip_newline true

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

function skey
    eval (ssh-agent -c)
    ssh-add ~/.ssh/usernicolas
end

function mdtodocx
    pandoc -o output.docx -f markdown -t docx $argv[1].md
end

function rcpp
    g++ *.cpp -o /tmp/main && /tmp/main
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

# # add ssh-key if shell is opened on startup, not in random shell instances
set parent_process (ps -o ppid= -p $fish_pid)
set parent_process (string trim $parent_process)
set parent_process (ps -o comm -p $parent_process | tail -n +2 | grep -v '^$')
set -l prev_command (history | head -n 1 | string trim)

if test "$parent_process" = su
    if not set -q SSH_AGENT_PID
        skey >/dev/null 2>&1
        echo "ssh-key added!"
    end
end

function server
    browser-sync start --no-open --server --files "src/*.css, *.html, src/*.js" &
end

function e
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        cd -- "$cwd"
    end
    /bin/rm -f -- "$tmp"
end

# ----------------------- #
#        ALIASES
# ----------------------- #

alias gs 'git status -s'
alias so 'source ~/.config/fish/config.fish'
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
alias l 'ls -l --group-directories-first --git -a'
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
alias nn /usr/bin/nvim
alias win "/mnt/c/Program\ Files/PowerShell/7/pwsh.exe"
alias powershell.exe "/mnt/c/Program\ Files/PowerShell/7/pwsh.exe"
alias cmd.exe "/mnt/c/Windows/System32/cmd.exe"
alias bd 'cd -'
alias pbcopy 'xsel --input --clipboard'
alias pbpaste 'xsel --output --clipboard'
alias live 'live-server --browser=/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe&'
# "C:\Program Files\WindowsApps\Microsoft.PowerShell_7.4.1.0_x64__8wekyb3d8bbwe\pwsh.exe"

# ----------------------- #
#     ABBREVIATIONS
# ----------------------- #

abbr cat bat
abbr cls clear
abbr lg lazygit
abbr gg lazygit
abbr n. 'nvim .'
abbr img 'wezterm imgcat'
abbr v vim
abbr g git
abbr q exit
abbr sl ls
abbr dc cd
abbr wther 'curl wttr.in'
abbr weather 'curl wttr.in'
abbr ra ranger
abbr n nvim
abbr ff fastfetch

# ----------------------- #
#       KEYBINDINGS
# ----------------------- #

# Bind Ctrl + Z to the select_job_with_fzf function
# bind -M insert \cz "select_job_with_fzf;commandline -f repaint"

bind -M insert \cz "fg; commandline -f repaint"
bind -M insert \e\[13\;5u accept-autosuggestion # control-enter for accept-autosuggestion
# below lines for fzf zoxide
bind -M insert \cP "__zoxide_zi; commandline -f kill-whole-line; commandline -f repaint"
bind -M insert \n "__zoxide_zi; commandline -f kill-whole-line; commandline -f repaint"
bind -M insert \e\x7F kill-whole-line repaint # use <M-BS> for clearing line
bind -M insert \cE "e; commandline -f repaint"
# bind \cg 'git diff; commandline -f repaint'
# bind -M insert \cc kill-whole-line repaint

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

# NOTE: To stop (base) in shell prompt, use `conda config --set auto_activate_base false`
