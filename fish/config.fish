# ~/.config/fish/config.fish

# 设置别名
alias lsl="ls -1 --group-directories-first -a"
alias cls="clear"
alias cl="clear"
# 新建一个会话打开neovide，确保neovide是一个独立的进程
alias neo="setsid neovide"
alias vi="nvim"
alias glog="git log --oneline"
alias yz="yazi"
alias rof="rofi -show drun"

# 函数
function yy
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# 在fish中启动starship. 
starship init fish | source

# 设置fish的代理，必须全部在这里指定，不然使用neovim打开shell还是有问题的。这样一劳永逸。
# # export https_proxy=http://127.0.0.1:7897 http_proxy=http://127.0.0.1:7897 all_proxy=socks5://127.0.0.1:7897
set -x http_proxy http://127.0.0.1:7897
set -x https_proxy http://127.0.0.1:7897
set -x all_proxy socks5://127.0.0.1:7897

if status is-interactive
    # Commands to run in interactive sessions can go here
end
