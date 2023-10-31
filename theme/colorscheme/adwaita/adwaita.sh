#!/usr/bin/env bash

source $HOME/.config/awesome/theme/desktop.sh

# Colors
BG="#1e1e1e"
FG="#eeeeee"
BL="#353535"
WH="#444444"
R="#ed333b"
G="#e66100"
Y="#ffa348"
B="#5bc8af"
M="#1c71d8"
C="#E05C91"

term
gtk "adwaita-base16"
browser $BG $BL $FG "#eeeeee" 
discord "https://raw.githubusercontent.com/tsukki9696/discord-themes/main/adwaita.theme.css"
nvim "adwaita"
