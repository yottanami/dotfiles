set PATH /home/yottanami/.local/bin/ $PATH
set PATH /home/yottanami/.rbenv/bin/ $PATH
set PATH /home/yottanami/.yarn/bin $PATH
set PATH /home/yottanami//bin/ $PATH
set PATH /home/yottanami/.platformio/penv/bin/ $PATH
set PATH /home/yottanami/bin/idea-IU-222.4167.29/bin/ $PATH
set fish_greeting
set FG42_V3 true
set -gx EDITOR emacs -nw
alias g="git"
alias k="kubectl"
alias dotfiles='/usr/bin/git --git-dir=/home/yottanami/.dotfiles/ --work-tree=/home/yottanami'
#status --is-interactive; and source (rbenv init -|psub)
status --is-interactive; and source (rbenv init - | sed 's/setenv/set -gx/' | psub)
eval (ssh-agent -c)

# Generated for envman. Do not edit.
test -s "$HOME/.config/envman/load.fish"; and source "$HOME/.config/envman/load.fish"

