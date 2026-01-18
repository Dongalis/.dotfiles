#!/usr/bin/env bash
set -euo pipefail

source ~/.dotfiles/stow-core.sh

POSITIONAL=()

usage() {
    echo "Usage: $0 [OPTIONS] PACKAGE [FILES...]"
    echo "Options:"
    echo "  --cmd CMD         associate a command with the package"
    echo "  -h, --help        show this help message"
    echo "Arguments:"
    echo "  PACKAGE           stow package name"
    echo "  FILES...          files to add to the package (absolute or relative to \$TARGET_DIR)"
}
# First, parse --cmd argument
while [[ $# -gt 0 ]]; do
    case "$1" in
        --cmd)
            shift
            CMD="$1"
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
#        --)
 #           shift
  #          break
   #         ;;
        *)
            POSITIONAL+=("$1")
            shift
            ;;
    esac
done

# Now POSITIONAL contains: package name + files
if [[ ${#POSITIONAL[@]} -lt 1 ]]; then
    echo "Error: package name is required"
    exit 1
fi

PACKAGE="${POSITIONAL[0]}"
FILES=("${POSITIONAL[@]:1}")


add_to_package "$PACKAGE" "${FILES[@]}"
if [[ -n "${CMD-}" ]]; then
    add_package_cmd "$PACKAGE" "$CMD"
fi

exit 0


