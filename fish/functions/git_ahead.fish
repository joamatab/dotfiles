function git_ahead
    set -l ahead $argv[1]
    set -l behind $argv[2]
    set -l diverged $argv[3]
    set -l none $argv[4]

    command git rev-list --left-right --count HEAD...@'{u}' 2>/dev/null | read -l -d \t left right

    set -q left[1]; or set left 0
    set -q right[1]; or set right 0

    if test $left -gt 0 -a $right -gt 0
        echo $diverged
    else if test $left -gt 0
        echo $ahead
    else if test $right -gt 0
        echo $behind
    else
        echo $none
    end
end
