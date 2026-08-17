
# Older Atuin installers created this optional environment file.  Homebrew
# installs the `atuin` executable on PATH directly, so only load it when it
# exists (the shell integration itself lives in config.fish).
if test -f "$HOME/.atuin/bin/env.fish"
# Older Atuin installers created this optional environment file.  Homebrew
# installs the `atuin` executable on PATH directly, so only load it when it
# exists (the shell integration itself lives in config.fish).
if test -f "$HOME/.atuin/bin/env.fish"
    source "$HOME/.atuin/bin/env.fish"
end
end
