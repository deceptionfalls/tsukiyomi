#!/usr/bin/env bash

source $HOME/.config/awesome/theme/desktop.sh

# Colors
BG="#0f0f0f"
FG="#c6c6c6"
BL="#161616"
WH="#262626"
R="#c1374b"
G="#CB604A"
Y="#D58848"
B="#32ae80"
M="#5e76de"
C="#9366d6"

term
gtk "fullerene-base16"
browser $BG $WH $FG "#393939" 
discord "https://raw.githubusercontent.com/tsukki9696/discord-themes/main/fullerene.theme.css"
nvim "fullerene"
