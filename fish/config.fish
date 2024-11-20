# ~/.config/fish/config.fish

set -g fish_greeting ""

function fish_greeting
    set_color magenta
    echo "🔯Hi, Spectrumzero!"
    set_color normal
end

# $PATH (append)
# Set variable
set -x JAVA_HOME /usr/lib/jvm/default
set -x IDEA_HOME /opt/intellij-idea-ultimate-edition
set -x LC ~/lazycoding/leetcode-grinding/source/cpp/
set -x NVIM ~/.config/nvim/
set -x SWAP ~/.local/state/nvim/swap/
set -x CODE ~/.config/Code/User/
# use IME
set -x XMODIFIERS '@im=fcitx'
set -x GTK_IM_MODULE fcitx
set -x QT_IM_MODULE fcitx

# Append variables to the default path;
set -x PATH $JAVA_HOME/bin $IDEA_HOME/bin $PATH

# set alias
alias lsl="ls -1 --group-directories-first -a"
alias cls="clear"
alias cl="clear"
# start a new independent process of neovide
alias neo="setsid neovide"
alias vi="nvim"
alias glog="git log --oneline"
alias yz="yazi"
alias rof="rofi -show drun"
alias lyh="learnyouhtml"
# open a html file in the default browser directly
alias chr="google-chrome-stable"
alias tr="tree"

# function
function yy
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# starship startup
starship init fish | source
# proxy settings
set -x http_proxy http://127.0.0.1:7897
set -x https_proxy http://127.0.0.1:7897
set -x all_proxy socks5://127.0.0.1:7897

# Integrate fzf. After setting up shell integration as below, you can use the following key-bindings in fish.
# `ctrl+t`: paste the selected files and directories onto the command line.
# `ctrl+r`: paste the selected commands from commands history onto the command line.
# `alt+c`: cd into the selected directory.
#
# btw, use `alt+jk` or `alt+np`(in the shell opened by neovim) to move cursor when selecting.
fzf --fish | source

if status is-interactive
    # Commands to run in interactive sessions can go here
end
