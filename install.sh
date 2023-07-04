#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")" || exit 2

glib-compile-schemas ./emoji-selector@maestroschan.fr/schemas

if (( $EUID == 0 )); then
	INSTALL_DIR="/usr/share/gnome-shell/extensions"
else
	INSTALL_DIR="$HOME/.local/share/gnome-shell/extensions"
fi
INSTALL_DIR="${INSTALL_DIR}/emoji-selector@maestroschan.fr"

if [[ ! -d $INSTALL_DIR ]]; then
	mkdir -p "$INSTALL_DIR"
fi

echo "Installing extension files in $INSTALL_DIR"
rsync -av --delete "emoji-selector@maestroschan.fr/" "${INSTALL_DIR}/"

echo "Done."
exit 0

