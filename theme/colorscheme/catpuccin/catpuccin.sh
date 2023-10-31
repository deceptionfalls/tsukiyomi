#!/usr/bin/env bash

source $HOME/.config/awesome/theme/desktop.sh

# Colors
BG="#1e1e2e"
FG="#cdd6f4"
BL="#45475a"
WH="#6c7086"
R="#f38ba8"
G="#fab387"
Y="#f9e2af"
B="#a6e3a1"
M="#89b4fa"
C="#cba6f7"

term
gtk "catppuccin-base16"
nvim "catppuccin-mocha"
browser $BG $BL $FG "#cdd6f4" 
discord "https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css"
