#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

eval "$(starship init bash)"
function set_win_title() {
	echo -ne "\033]0; $USER@$HOST:${PWD/$HOME/~} \007"
}

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias neofetch="neofetch --ascii ~/.config/neofetch/ascii --ascii_colors 6 7 1"


export VISUAL=nvim
export EDITOR=nvim

#export XDG_DATA_HOME=$HOME/.local/share
#export PATH=$XDG_DATA_HOME/bob/nvim-bin:$PATH

# Shortcut key 
alias g="lazygit"
alias gd="gh dash"
alias r="ranger"
