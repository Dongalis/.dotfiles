#!/usr/bin/env bash
set -euo pipefail

# ---------------------------------------------------------------------------
# Dispatcher for "dotfiles update"
# ---------------------------------------------------------------------------

# Load core functions
source "$HOME/.local/lib/dotfiles/core.sh"

SUBCMD="update"
DISPATCHER_CMD="dotfiles"

# ---------------------------------------------------------------------------
# Usage function
# ---------------------------------------------------------------------------
usage() {
    cat <<EOF
Usage: $DISPATCHER_CMD $SUBCMD [options]
Options:
  -h, --help        Show this help message
EOF
}

# ---------------------------------------------------------------------------
# Parse command-line arguments
# ---------------------------------------------------------------------------
FORCE_UPDATE=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            usage
            exit 0
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Unknown option: $1" >&2
            usage
            exit 1
            ;;
    esac
    shift
done

check_git_repo || exit 1
check_uncommitted_changes || exit 1
fetch_updates
pull_updates || exit 1
show_recent_commits
echo
echo "✅ Dotfiles repository is up to date."
