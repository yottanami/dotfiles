set PATH /home/yottanami/.local/bin/ $PATH
set PATH /home/yottanami/.rbenv/bin/ $PATH
set PATH /home/yottanami/.yarn/bin $PATH
set PATH /home/yottanami//bin/ $PATH
set PATH /home/yottanami/.platformio/penv/bin/ $PATH
set fish_greeting
set FG42_V3 true
set -gx EDITOR emacs -nw
alias g="git"
alias k="kubectl"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
status --is-interactive; and source (rbenv init -|psub)
eval (ssh-agent -c)
