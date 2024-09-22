if status is-interactive
    # Commands to run in interactive sessions can go here
end

# ----------------------- #
#       VARIABLES
# ----------------------- #

# set -e fish_user_paths
set -e fish_user_paths
set -Ux fish_user_paths $fish_user_paths /home/nicolas/julia-1.8.1/bin /home/nicolas/.cargo/bin/ /usr/lib/jvm/java-1.11.0-openjdk-amd64/lib/server /home/linuxbrew/.linuxbrew/bin/R
set -g async_prompt_functions _pure_prompt_git

set -Ux EDITOR /usr/bin/nvim # set correct editor
set -gx EDITOR nvim # set correct editor
set -Ux FZF_DEFAULT_OPTS "--height 100% --no-preview "
set -x DISPLAY :0 # fix vscode
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv) # some brew stuff
set fish_prompt_pwd_dir_length 0 # don't abbreviate paths in prompt
set -Ux FZF_FIND_FILE_COMMAND "find . -type d -name .git -prune -o -type f -print"
set -Ux FZF_OPEN_COMMAND "fd --type f --exclude .git --hidden"
set -Ux JAVA_HOME /usr/lib/jvm/java-1.11.0-openjdk-amd64/

# zoxide init --cmd j fish | source # zoxide
theme_tokyonight night

# # #2bbac5
set pure_color_primary 34e2e2
# # #8ae234
set pure_color_success 8ae234
# # #4e9a06
set pure_color_info 4e9a06
# # #4e9a06
set pure_color_mute 4e9a06

set --global hydro_symbol_git_dirty '*'
set --global fish_prompt_pwd_dir_length 100

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

function prepend_command
    set -l prepend $argv[1]
    if test -z "$prepend"
        echo "prepend_command needs one argument."
        return 1
    end

    set -l cmd (commandline)
    if test -z "$cmd"
        commandline -r $history[1]
    end

    set -l old_cursor (commandline -C)
    commandline -C 0
    commandline -i "$prepend "
    commandline -C (math $old_cursor + (echo $prepend | wc -c))
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
alias .. 'cd ..'
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ls 'eza --icons=always --group-directories-first' # add colors and file type extensions
alias la 'ls -Alh --group-directories-first' # show hidden files
alias l 'ls -l --group-directories-first --git -a'
alias lt 'ls --tree' # tree
alias p "ps aux | grep " # Search running processes
alias f "find . | grep " # Search files in the current folder
alias exp 'wsl-open .' # wsl specific, open explorer in cwd
alias shutdown '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -c wsl --shutdown'
alias nala 'sudo nala'
alias csv csvlens
alias win "/mnt/c/Program\ Files/PowerShell/7/pwsh.exe"
alias wintop 'win --c "btop"'
alias powershell.exe "/mnt/c/Program\ Files/PowerShell/7/pwsh.exe"
alias cmd.exe "/mnt/c/Windows/System32/cmd.exe"

# ----------------------- #
#     ABBREVIATIONS
# ----------------------- #

abbr lg lazygit
abbr n. 'nvim .'
abbr v vim
abbr g git
abbr q exit
abbr sl ls
abbr dc cd
abbr weather 'curl wttr.in'
abbr n nvim
abbr ff fastfetch

# ----------------------- #
#       KEYBINDINGS
# ----------------------- #

bind -M insert \cz "fg; commandline -f repaint"
bind -M insert \e\[13\;5u accept-autosuggestion # control-enter for accept-autosuggestion

# below lines for fzf zoxide
bind -M insert \cP "__zoxide_zi; commandline -f kill-whole-line; commandline -f repaint"
bind -M insert \n "__zoxide_zi; commandline -f kill-whole-line; commandline -f repaint"

bind -M insert \e\x7F kill-whole-line repaint # use <M-BS> for clearing line
bind -M insert \cE "e; commandline -f repaint"
bind -M insert \cS "prepend_command sudo"

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

# =============================================================================
#
# Utility functions for zoxide.
#

# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd
    builtin pwd -L
end

# A copy of fish's internal cd function. This makes it possible to use
# `alias cd=z` without causing an infinite loop.
if ! builtin functions --query __zoxide_cd_internal
    string replace --regex -- '^function cd\s' 'function __zoxide_cd_internal ' <$__fish_data_dir/functions/cd.fish | source
end

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd
    if set -q __zoxide_loop
        builtin echo "zoxide: infinite loop detected"
        builtin echo "Avoid aliasing `cd` to `z` directly, use `zoxide init --cmd=cd fish` instead"
        return 1
    end
    __zoxide_loop=1 __zoxide_cd_internal $argv
end

# =============================================================================
#
# Hook configuration for zoxide.
#

# Initialize hook to add new entries to the database.
function __zoxide_hook --on-variable PWD
    test -z "$fish_private_mode"
    and command zoxide add -- (__zoxide_pwd)
end

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

# Jump to a directory using only keywords.
function __zoxide_z
    set -l argc (builtin count $argv)
    if test $argc -eq 0
        __zoxide_cd $HOME
    else if test "$argv" = -
        __zoxide_cd -
    else if test $argc -eq 1 -a -d $argv[1]
        __zoxide_cd $argv[1]
    else if test $argc -eq 2 -a $argv[1] = --
        __zoxide_cd -- $argv[2]
    else
        set -l result (command zoxide query --exclude (__zoxide_pwd) -- $argv)
        and __zoxide_cd $result
    end
end

# Completions.
function __zoxide_z_complete
    set -l tokens (builtin commandline --current-process --tokenize)
    set -l curr_tokens (builtin commandline --cut-at-cursor --current-process --tokenize)

    if test (builtin count $tokens) -le 2 -a (builtin count $curr_tokens) -eq 1
        # If there are < 2 arguments, use `cd` completions.
        complete --do-complete "'' "(builtin commandline --cut-at-cursor --current-token) | string match --regex -- '.*/$'
    else if test (builtin count $tokens) -eq (builtin count $curr_tokens)
        # If the last argument is empty, use interactive selection.
        set -l query $tokens[2..-1]
        set -l result (command zoxide query --exclude (__zoxide_pwd) --interactive -- $query)
        and __zoxide_cd $result
        and builtin commandline --function cancel-commandline repaint
    end
end
complete --command __zoxide_z --no-files --arguments '(__zoxide_z_complete)'

# Jump to a directory using interactive search.
function __zoxide_zi
    set -l result (command zoxide query --interactive -- $argv)
    and __zoxide_cd $result
end

# =============================================================================
#
# Commands for zoxide. Disable these using --no-cmd.
#

# builtin abbr --erase j &>/dev/null
abbr --erase j &>/dev/null
alias j=__zoxide_z

# builtin abbr --erase ji &>/dev/null
abbr --erase ji &>/dev/null
alias ji=__zoxide_zi

# =============================================================================
