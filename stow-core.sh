#!/usr/bin/env bash
set -euo pipefail

# Directory containing dotfiles
DOTFILES_DIR="$HOME/.dotfiles"
export STOW_DIR="$DOTFILES_DIR"

MAP_FILE="$DOTFILES_DIR/deploy_map.conf"

# Directory where dotfiles will be deployed to
TARGET_DIR="$HOME"

STOW_OPTS=()
ALLOW_ADOPT_INTERACTIVE=false

# Function to deploy a stow package
deploy_if_available() {
    local cmd="$1"      # command to check
    local package="$2"  # stow package name (folder in dotfiles dir)

    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Skipping $package (command '$cmd' not found)"
        return 0
    fi

    echo "Deploying $package ${STOW_OPTS[*]}"

    if stow "${STOW_OPTS[@]}" -t "$TARGET_DIR" "$package" --no-folding; then
        return 0
    fi

    echo "⚠️  Stow failed for $package"

    if [[ "$ALLOW_ADOPT_INTERACTIVE" != true ]]; then
        echo "Interactive adopt prompt disabled. Skipping $package."
        return 1
    fi

    # If --adopt already enabled, do not retry
    if [[ " ${STOW_OPTS[*]} " == *" --adopt "* ]]; then
        echo "Already using --adopt, not retrying."
        return 1
    fi

    read -rp "Retry $package with --adopt? [y/N] " answer
    case "$answer" in
        y|Y)
            echo "Retrying $package with --adopt..."
            stow --adopt -t "$TARGET_DIR" "$package" --no-folding
            ;;
        *)
            echo "Skipping $package."
            ;;
    esac
}

autodeploy_all() {
    [[ ! -f "$MAP_FILE" ]] && { echo "Deploy map not found: $MAP_FILE"; return 1; }

    while IFS=: read -r cmd pkg allow_adopt; do
        # Skip empty lines and comments
        [[ -z "$cmd" || "$cmd" =~ ^# ]] && continue


        deploy_if_available "$cmd" "$pkg"

    done < "$MAP_FILE"

}

add_to_package() {
    local package="$1"
    shift
    local files=("$@")

    for f in "${files[@]}"; do

        if [[ ! -e "$f" ]]; then
            echo "Skipping $f: does not exist"
            continue 
        fi

        if [[ -L "$f" ]]; then
            echo "Skipping $f: is a symlink"
            continue 
        fi
        local rel
        rel=$(realpath --relative-to="$TARGET_DIR" "$f")

        if [[ "$rel" == ..* ]]; then
            echo "Skipping $f: outside of \"$TARGET_DIR\" directory"
            continue  # file is outside
        fi

        local dest
        dest="$STOW_DIR/$package/$rel"
        
        mkdir -p "$(dirname "$dest")"
        touch "$dest"
        echo "Added $rel to package $package"

    done

    stow --adopt -t "$TARGET_DIR" "$package" --no-folding
}

add_package_cmd() {
    local package="$1"
    local cmd="$2"

    if [[ ! -d "$STOW_DIR/$package" ]]; then
        echo "Package '$package' does not exist in $STOW_DIR. Aborting."
        return 1
    fi

    local entry="$cmd:$package"
    # Make sure deploy_map exists
    touch "$MAP_FILE"

    # If the exact entry already exists, do nothing
    if grep -Fxq "$entry" "$MAP_FILE"; then
        echo "Entry '$entry' already exists in $MAP_FILE, skipping."
        return 0
    fi

    # Remove any existing line for this package
    if grep -q ":$package\$" "$MAP_FILE"; then
        local existing=$(grep ":$package\$" "$MAP_FILE")
        echo "A different entry for package '$package' exists: $existing"
        read -rp "Do you want to override it? [y/N] " answer
        case "$answer" in
            y|Y)
                sed -i.bak "/:$package$/d" "$MAP_FILE"
                ;;
            *)
                echo "Keeping existing entry. Aborting."
                return 0
                ;;
        esac
    fi

    # Add new entry
    echo "$cmd:$package" >> "$MAP_FILE"

    echo "Added $package with command '$cmd' to $MAP_FILE"
}
