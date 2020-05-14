set TTY (tty)
if [ -z "$DISPLAY" ]; and [ -n "$TTY" ]; and [ $TTY = "/dev/tty1" ]
	$HOME/.local/bin/daily-update.sh
	exec sway
end
