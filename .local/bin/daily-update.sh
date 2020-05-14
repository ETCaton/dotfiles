#!/usr/bin/env bash
if [[ -z "$(last --since today --until now etcaton | head -2 | tail -1)" ]]; then
	fortune -a | cowsay -f "$(cowsay -l | rg -v ":.*" | tr " " "\n" | sort -R | head -1)"
	topgrade
fi
