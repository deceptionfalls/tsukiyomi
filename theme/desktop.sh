# paths
config="$HOME/.config"
nvim="$config/nvim"
xresources="$HOME/.Xresources"
gtk="$config/gtk-3.0/settings.ini"
firefox="$HOME/.mozilla/firefox/eui5p2r2.default-release/chrome"
discord="$config/Vencord/themes"

term() {
# Xresources
sed -i -e "s/#define FG .*/#define FG $FG/g" \
       -e "s/#define BG .*/#define BG $BG/g" \
       -e "s/#define BL .*/#define BL $BL/g" \
       -e "s/#define WH .*/#define WH $WH/g" \
       -e "s/#define R .*/#define R $R/g" \
       -e "s/#define G .*/#define G $G/g" \
       -e "s/#define Y .*/#define Y $Y/g" \
       -e "s/#define B .*/#define B $B/g" \
       -e "s/#define M .*/#define M $M/g" \
       -e "s/#define C .*/#define C $C/g" $xresources

# Update Xresources, Terminals, and Vim
xrdb $xresources
pidof st | xargs kill -s USR1

}

gtk() {
sed -i -e "s/gtk-theme-name=.*/gtk-theme-name=$1/g" $gtk
sed -i -e "s/Net\/ThemeName .*/Net\/ThemeName \"$1\"/g" $HOME/.config/xsettingsd/xsettingsd.conf

# Apply
killall xsettingsd
xsettingsd &
}

browser() {
sed -i -e "s/--bg: .*/--bg: $1;/g" \
	   -e "s/--bg-alt: .*/--bg-alt: $2;/g" \
       -e "s/--fg: .*/--fg: $3;/g" \
       -e "s/--fg-alt: .*/--fg-alt: $4;/g" $firefox/userChrome.css
}

css() {
sed -i -e "s/--bg: .*/--bg: $1 !important;/g" \
       -e "s/--bg2: .*/--bg2: $2 !important;/g" \
       -e "s/--bg3: .*/--bg3: $3 !important;/g" \
       -e "s/--fg: .*/--fg: $4 !important;/g" $firefox/userContent.css
}

nvim() {
  sed -i -e "s/vim.cmd 'colorscheme .*'/vim.cmd 'colorscheme $1'/" $config/nvim/init.lua
}

discord() {
  sed -i -e "s|@import url('.*')|@import url('$1')|" $discord/whatever.theme.css
}
