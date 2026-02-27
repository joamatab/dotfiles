function git_is_repo
    test -d .git
    or command git rev-parse --git-dir >/dev/null 2>&1
end
