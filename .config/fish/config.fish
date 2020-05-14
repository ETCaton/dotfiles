set fish_greeting
set -x PATH $HOME/.local/bin $PATH
alias cat=bat
alias grep=rg
alias ls=exa
alias vim=nvim
alias youtube-dl='youtube-dl -f bestvideo+bestaudio/best -o "%(title)s.%(ext)s"'
alias youtube-audio-dl='youtube-dl -i --extract-audio -f bestaudio/best --audio-format flac -o "%(title).s%(ext)s"'
set -x GPG_TTY (tty)
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpg-connect-agent updatestartuptty /bye >/dev/null
set FISH_PROMPT (command -v starship)
eval ($FISH_PROMPT init fish)
test $TERM != "screen"; and exec tmux new "neofetch && fish"
