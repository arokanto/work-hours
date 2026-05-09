#!/bin/sh
set -e

INSTALL_DIR="$HOME/.local/bin"
BIN="$INSTALL_DIR/wh"
RAW_URL="https://raw.githubusercontent.com/arokanto/work-hours/main/wh.sh"

mkdir -p "$INSTALL_DIR"
curl -fsSL "$RAW_URL" -o "$BIN"
chmod +x "$BIN"

case ":$PATH:" in
    *":$INSTALL_DIR:"*)
        ;;
    *)
        case "${SHELL##*/}" in
            zsh)  PROFILE="$HOME/.zprofile" ;;
            bash) PROFILE="$HOME/.bash_profile" ;;
            *)    PROFILE="$HOME/.profile" ;;
        esac
        printf '\nexport PATH="%s:$PATH"\n' "$INSTALL_DIR" >> "$PROFILE"
        echo "Added $INSTALL_DIR to PATH in $PROFILE — open a new terminal or run: source $PROFILE"
        ;;
esac

echo "Installed: $BIN"
