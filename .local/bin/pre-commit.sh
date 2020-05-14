#!/usr/bin/env bash
set -euo pipefail
# Maybe there is a more elegant way to not mess up permissions
cat /etc/nixos/configuration.nix >configuration.nix
# Delete "lonely" comments. Explanatory comments after lines will be removed
sed -i 's:^\s*#.*$::g' configuration.nix
# Delete trailing whitespace
sed -i 's/[ \t]*$//' configuration.nix
# Delete empty lines
sed -i '/^$/d' configuration.nix
# Above could be one super unweildy regex
LINE_NUM=0
IFS=$'\n'
# ^ Split cat by newline. v Don't use while loop, need user input
#shellcheck disable=SC2013
for LINE in $(cat configuration.nix); do
	LINE_NUM=$((LINE_NUM + 1))
	echo -e "\033[0;35m$LINE\033[0;35m\c"
	read -r TEXT
	if [[ -n "$TEXT" ]]; then
		sed -i "$LINE_NUM c\
#  $TEXT" configuration.nix
	fi
done
