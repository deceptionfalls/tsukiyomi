#!/usr/bin/env bash

source $HOME/.config/awesome/theme/desktop.sh

# Colors
BG="#eff1f5"
FG="#4c4f69"
BL="#e6e9ef"
WH="#9ca0b0"
R="#d20f39"
G="#fe640b"
Y="#df8e1d"
B="#40a02b"
M="#04a5e5"
C="#ea76cb"

term
gtk "latte-base16"
nvim "catppuccin-latte"
browser $BG $WH $FG "#4c4f69" 
discord "https://catppuccin.github.io/discord/dist/catppuccin-latte-sky.theme.css"
