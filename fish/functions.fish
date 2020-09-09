# thx to https://github.com/mduvall/config/

function subl --description 'Open Sublime Text'
  if test -d "/Applications/Sublime Text.app"
    "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" $argv
  else if test -d "/Applications/Sublime Text 2.app"
    "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" $argv
  else if test -x "/opt/sublime_text/sublime_text"
    "/opt/sublime_text/sublime_text" $argv
  else if test -x "/opt/sublime_text_3/sublime_text"
    "/opt/sublime_text_3/sublime_text" $argv
  else
    echo "No Sublime Text installation found"
  end
end

function loc --description "zfz with locatef"
  glocate --database=(brew --prefix)/var/locate/locatedb --all --ignore-case --null $argv | ggrep --null --invert-match --extended-regexp '~$' | fzf --read0 -0 -1 -m
end

function killf
  if ps -ef | sed 1d | fzf -m | awk '{print $2}' > $TMPDIR/fzf.result
    kill -9 (cat $TMPDIR/fzf.result)
  end
end

function clone --description "clone something, cd into it"
    git clone --depth=1 $argv[1]
    cd (basename $argv[1] | sed 's/.git$//')
end


function md --wraps mkdir -d "Create a directory and cd into it"
  command mkdir -p $argv
  if test $status = 0
    switch $argv[(count $argv)]
      case '-*'
      case '*'
        cd $argv[(count $argv)]
        return
    end
  end
end

function gz --d "Get the gzipped size"
  echo "orig size    (bytes): "
  cat "$argv[1]" | wc -c | gnumfmt --grouping
  echo "gzipped size (bytes): "
  gzip -c "$argv[1]" | wc -c | gnumfmt --grouping
end

function sudo!!
    eval sudo $history[1]
end


# `shellswitch [bash|zsh|fish]`
function shellswitch
	chsh -s (brew --prefix)/bin/$argv
end

function code
  env VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCodeInsiders" --args $argv
end

function upgradeyarn
  curl -o- -L https://yarnpkg.com/install.sh | bash
end

function fuck -d 'Correct your previous console command'
    set -l exit_code $status
    set -l eval_script (mktemp 2>/dev/null ; or mktemp -t 'thefuck')
    set -l fucked_up_commandd $history[1]
    thefuck $fucked_up_commandd > $eval_script
    . $eval_script
    rm $eval_script
    if test $exit_code -ne 0
        history --delete $fucked_up_commandd
    end
end

function server -d 'Start a HTTP server in the current dir, optionally specifying the port'
    if test $argv[1]
        set port $argv[1]
    else
        set port 8000
    end

    open "http://localhost:$port/" &
    # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
    # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
#     python -c "import SimpleHTTPServer
# map = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;
# map[\"\"] = \"text/plain\";
# for key, value in map.items():
#   map[key] = value + \";charset=UTF-8\";
#   SimpleHTTPServer.test()" $port
    statikk --port "$port" .
end


function emptytrash -d 'Empty the Trash on all mounted volumes and the main HDD. then clear the useless sleepimage'
    sudo rm -rfv "/Volumes/*/.Trashes"
    grm -rf "~/.Trash/*"
    rm -rfv "$HOME/Library/Application Support/stremio/Cache"
    rm -rfv "$HOME/Library/Application Support/stremio/stremio-cache"
    rm -rfv "~/Library/Application Support/Spotify/PersistentCache/Update/*.tbz"
    rm -rfv ~/Library/Caches/com.spotify.client/Data
    rm -rfv ~/Library/Caches/Firefox/Profiles/98ne80k7.dev-edition-default/cache2
end


# Change working dir in fish to last dir in lf on exit (adapted from ranger).
#
# You may put this file to a directory in $fish_function_path variable:
#
#     mkdir -p ~/.config/fish/functions
#     ln -s "/path/to/lfcd.fish" ~/.config/fish/functions
#
# You may also like to assign a key to this command:
#
#     bind \co 'lfcd; commandline -f repaint'
#
# You need to put this in a function called fish_user_key_bindings.

function lfcd
    set tmp (mktemp)
    lf -last-dir-path=$tmp $argv
    if test -f "$tmp"
        set dir (cat $tmp)
        rm -f $tmp
        if test -d "$dir"
            if test "$dir" != (pwd)
                cd $dir
            end
        end
    end
end

function dedup_path --description "Removes duplicate entries from \$PATH"
  set -l NEWPATH
  for p in $PATH
    if not contains $NEWPATH $p
      set NEWPATH $NEWPATH $p
    end
  end
  set PATH $NEWPATH
end

function git_is_repo -d "Test if the current directory is a Git repository"
    if not command git rev-parse --git-dir > /dev/null 2>/dev/null
        return 1
    end
end

