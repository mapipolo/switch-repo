# switch-repo: cd into a git repo under ~/Source
# Source this file in your .zshrc: source /path/to/switch-repo

switch-repo() {
    local base="$HOME/Source"

    if [[ -z "$1" ]]; then
        cd "$base"
        return
    fi

    if [[ "$1" == "/" ]]; then
        local repo_root
        repo_root=$(git rev-parse --show-toplevel 2>/dev/null)
        if [[ -z "$repo_root" ]]; then
            echo "switch-repo: not inside a git repository" >&2
            return 1
        fi
        cd "$repo_root"
        return
    fi

    local target="$base/$1"
    if [[ ! -d "$target" ]]; then
        echo "switch-repo: directory not found: $target" >&2
        return 1
    fi

    cd "$target"
}

_switch-repo() {
    local base="$HOME/Source"
    # fd returns paths like /Users/michael/Source/foo/bar/.git
    # Strip the base prefix and the trailing /.git
    local repos=(${(f)"$(fd -t d -H -g .git "$base" 2>/dev/null | sed "s|^${base}/||" | sed 's|/\.git/$||;s|/\.git$||')"})
    _describe 'repo' repos
}

compdef _switch-repo switch-repo
