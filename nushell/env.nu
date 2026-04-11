#
# Nushell Environment Config File
#

def create_left_prompt [] {
    let dir = match (do -i { $env.PWD | path relative-to $nu.home-path }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }

    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
    let path_segment = $"($path_color)($dir)"

    $path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"
}

def create_right_prompt [] {
    let time_segment = ([
        (ansi reset)
        (ansi magenta)
        (date now | format date '%x %X')
    ] | str join | str replace --regex --all "([/:])" $"(ansi green)${1}(ansi magenta)" |
        str replace --regex --all "([AP]M)" $"(ansi magenta_underline)${1}")

    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
        (ansi rb)
        ($env.LAST_EXIT_CODE)
    ] | str join)
    } else { "" }

    ([$last_exit_code, (char space), $time_segment] | str join)
}

$env.PROMPT_COMMAND = {|| create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }

$env.PROMPT_INDICATOR = {|| "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts')
    ($nu.data-dir | path join 'completions')
]

$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins')
]

# PATH (mirrors fish config.fish path_prepend/path_append)
use std "path add"
path add /opt/homebrew/bin
path add /opt/homebrew/sbin
path add ($env.HOME | path join ".local/bin")
path add ($env.HOME | path join ".cargo/bin")
path add ($env.HOME | path join ".juliaup/bin")
path add ($env.HOME | path join "go/bin")
path add ($env.HOME | path join "bin")
path add ($env.HOME | path join "dotfiles/scripts")
path add ($env.HOME | path join ".fzf/bin")
path add ($env.HOME | path join ".yarn/bin")
path add ($env.HOME | path join ".npm-global/bin")
path add ($env.HOME | path join ".poetry/bin")
path add ($env.HOME | path join ".pyenv/bin")
path add ($env.HOME | path join ".pulumi/bin")
path add ($env.HOME | path join ".rbenv/bin")
path add ($env.HOME | path join ".config/yarn/global/node_modules/.bin")
path add ($env.HOME | path join "snap/bin")
path add ($env.HOME | path join "dotfiles/extra/luke/.local/bin")
path add /usr/local/sbin
path add /opt/homebrew/opt/ruby/bin

# Conditional PATH entries
for $p in [
    ($env.HOME | path join ".rbenv/versions/3.4.4/bin")
    ($env.HOME | path join "mambaforge/bin")
    ($env.HOME | path join "miniconda3/bin")
    ($env.HOME | path join "dotfiles/scripts/mac")
    "/opt/lumerical/v251/bin"
    "/opt/lumerical/v242/bin"
] {
    if ($p | path exists) { path add $p }
}

# Starship prompt
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

# Zoxide
zoxide init nushell | save -f ~/.zoxide.nu

# Atuin
atuin init nu | save -f ~/.local/share/atuin/init.nu

# Variables (mirrors fish config.fish variables section)
$env.STARSHIP_CONFIG = ($env.HOME | path join ".config/starship.toml")
$env.EDITOR = "nvim"
$env.GIT_EDITOR = "nvim"
$env.PAGER = "bat"
$env.TERM = "xterm-256color"
$env.FZF_DEFAULT_COMMAND = "fd"
$env.FZF_LEGACY_KEYBINDINGS = "0"
$env.RIPGREP_CONFIG_PATH = ($env.HOME | path join ".ripgreprc")
$env.UV_LINK_MODE = "hardlink"
$env.PRE_COMMIT_COLOR = "never"

if ("Darwin" == (sys host | get name)) {
    $env.OPENER = "open"
    $env.BROWSER = "firefox"
}

if (($env.HOME | path join ".ssh/id_rsa") | path exists) {
    $env.SSH_KEY_PATH = ($env.HOME | path join ".ssh/id_rsa")
}
