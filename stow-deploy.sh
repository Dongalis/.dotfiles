#!/usr/bin/env bash
set -euo pipefail

source ~/.dotfiles/stow-core.sh

ALLOW_ADOPT_INTERACTIVE=false


usage() {
    echo "Usage: $0 [--adopt] [--allow-adopt]"
    echo "Options:"
    echo "  --adopt           deploy all packages with --adopt"
    echo "  --allow-adopt     enable interactive retry prompt when stow fails"
    echo "  -h, --help        show this message"
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --adopt)
            STOW_OPTS+=(--adopt)
            ;;
        --allow-adopt)
            ALLOW_ADOPT_INTERACTIVE=true
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
    shift
done


autodeploy_all
exit 0


