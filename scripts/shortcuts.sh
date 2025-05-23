#!/bin/bash
# https://github.com/lukesmithxyz/voidrice
# Output locations. Unactivated progs should go to /dev/null.

shell_shortcuts="$HOME/.shortcuts"
ranger_shortcuts="$HOME/.config/ranger/shortcuts.conf"
fish_shortcuts="$HOME/.shortcuts.fish"
vifm_shortcuts="$HOME/.config/vifm/vifmshortcuts"

# Remove, prepare files
rm -f "$ranger_shortcuts" "$qute_shortcuts" 2>/dev/null
printf "# vim: filetype=sh\\n" > "$fish_shortcuts"
printf "# vim: filetype=sh\\nalias " > "$shell_shortcuts"
printf "\" vim: filetype=vim\\n" > "$vifm_shortcuts"

# Format the `bmdirs` file in the correct syntax and sent it to all three configs.
sed "s/\s*#.*$//;/^\s*$/d" "$HOME/.bmdirs" | tee >(awk '{print $1"=\"cd "$2" && ls -a\" \\"}' >> "$shell_shortcuts") \
  >(awk '{print $1, "\"cd " $2 "; and ls -a\" \\"}' >> "$fish_shortcuts") \
	>(awk '{print "config.bind(\";"$1"\", \"set downloads.location.directory "$2" ;; hint links download\")"}' >> "$qute_shortcuts") \
	| awk '{print "map g"$1" cd "$2"\nmap t"$1" tab_new "$2"\nmap m"$1" shell mv -v %s "$2"\nmap Y"$1" shell cp -rv %s "$2}' >> "$ranger_shortcuts"

# Format the `configs` file in the correct syntax and sent it to both configs.
sed "s/\s*#.*$//;/^\s*$/d"  "$HOME/.bmfiles" | tee >(awk '{print $1"=\"$EDITOR "$2"\" \\"}' >> "$shell_shortcuts") \
	>(awk '{print $1, "\"$EDITOR "$2"\" \\"}' >> "$fish_shortcuts") \
	| awk '{print "map "$1" shell $EDITOR "$2}' >> "$ranger_shortcuts"
