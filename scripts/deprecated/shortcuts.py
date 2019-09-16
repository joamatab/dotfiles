#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import csv
from re import sub
from re import compile
import os

# fishshortcuts = ""
qute_shortcuts = ""
ranger_shortcuts = ""
bash_shortcuts = ""
fish_shortcuts = ""

home = os.getenv("HOME") + "/"
ranger_location = home + "dotfiles/ranger/shortcuts.conf"
zsh_location = home + ".shortcuts"
fish_location = home + ".shortcuts.fish"
qute_location = home + ".config/qutebrowser/config.py"
folders_location = home + ".bmdirs"
configs_location = home + ".bmfiles"

# These are the labels that demarcate where the shortcuts
# go in the config files.
beg = "# DO NOT DELETE LMAO\n"
end = "# DO NOT DELETE LMAO"

# First we open the list of folder shortcuts and go down each line adding each
# in the required syntax to each of the three configs:
with open(folders_location) as fold:
    for line in csv.reader(fold, dialect="excel-tab"):
        # Adds the ranger go, tab, move and yank commands:
        ranger_shortcuts += "map g" + line[0] + " cd " + line[1] + "\n"

        ranger_shortcuts += "map t" + line[0] + " tab_new " + line[1] + "\n"

        ranger_shortcuts += "map m" + line[0] + " shell mv %s " + line[1] + "\n"

        ranger_shortcuts += (
            "map Y" + line[0] + " shell cp -r %s " + line[1] + "\n"
        )

        # Adds the bash_shortcuts shortcuts:
        bash_shortcuts += (
            "alias " + line[0] + '="cd ' + line[1] + ' && ls "' + "\n"
        )
        fish_shortcuts += (
            "abbr -a " + line[0] + ' "cd ' + line[1] + '; and ls -a"' + "\n"
        )

        # qutebrowser shortcuts:
        qute_shortcuts += (
            "config.bind(';"
            + line[0]
            + "', 'set downloads.location.directory "
            + line[1]
            + " ;; hint links download')"
            + "\n"
        )


# Goes thru the config file file and adds the shortcuts to both
# bash_shortcuts and ranger.
with open(configs_location) as conf:
    for line in csv.reader(conf, dialect="excel-tab"):
        # fishshortcuts+=("alias "+line[0]+"=\"vi "+line[1]+"\"\n")
        # fishshortcuts+=("abbr --add "+line[0]+" \"vi "+line[1]+"\"\n")
        bash_shortcuts += "alias " + line[0] + '="vi ' + line[1] + '"' + "\n"
        fish_shortcuts += "abbr -a " + line[0] + ' "vi ' + line[1] + '"' + "\n"
        ranger_shortcuts += "map " + line[0] + " shell vi " + line[1] + "\n"


def replaceInMarkers(text, shortcuts):
    markers = compile(beg + "(.|\s)*" + end)
    replacement = beg + shortcuts + end
    return sub(markers, replacement, text)


def writeShortcuts(location, shortcuts):
    with open(location, "r+") as input:
        input.write(shortcuts)
        # final = ""
        # final += input.read()
        # final = replaceInMarkers(final, shortcuts)
        # input.seek(0)
        # input.write(final)
        # input.truncate()


def main():
    writeShortcuts(ranger_location, ranger_shortcuts)
    writeShortcuts(zsh_location, bash_shortcuts)
    writeShortcuts(fish_location, fish_shortcuts)
    writeShortcuts(qute_location, qute_shortcuts)


if __name__ == "__main__":
    main()
