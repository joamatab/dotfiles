function git_branch_name
    command git symbolic-ref --short HEAD 2>/dev/null
    or command git describe --tags --exact-match HEAD 2>/dev/null
    or command git rev-parse --short HEAD 2>/dev/null
end
