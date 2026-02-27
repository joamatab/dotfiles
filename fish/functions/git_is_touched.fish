function git_is_touched
    string length -q (command git status --porcelain 2>/dev/null)
end
