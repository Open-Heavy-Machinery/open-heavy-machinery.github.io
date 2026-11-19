#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0
# Renders the PNG and JPG versions of the logo from the SVGs in assets/logo/,
# with headless Chrome (transparent background) and Python's Pillow (JPG).
#
# Usage: tools/logo/render.sh   (needs google-chrome or chromium, python3 with Pillow)
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/../.." && pwd)
LOGO="$ROOT/assets/logo"
CHROME=$(command -v google-chrome || command -v chromium || command -v chromium-browser)
WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT

# render <svg> <width> <height> <png> [background]
render() {
    local bg=${5:-transparent}
    cat >"$WORK/page.html" <<HTML
<!doctype html><html><head><style>
html, body { margin: 0; padding: 0; background: $bg; overflow: hidden; }
img { display: block; width: ${2}px; height: ${3}px; }
</style></head><body><img src="file://$LOGO/$1"></body></html>
HTML
    "$CHROME" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 \
        --default-background-color=00000000 --allow-file-access-from-files \
        --window-size="$2,$3" --screenshot="$LOGO/$4" "file://$WORK/page.html" 2>/dev/null
    echo "wrote assets/logo/$4 (${2}x${3})"
}

render mark.svg 512 512 mark-512.png
render mark-light.svg 512 512 mark-light-512.png
render icon.svg 512 512 icon-512.png
render icon.svg 1024 1024 icon-1024.png
render wordmark-dark.svg 1880 256 wordmark-dark.png
render wordmark-light.svg 1880 256 wordmark-light.png

# JPG has no transparency: the icon on its own dark background, square corners.
render icon.svg 512 512 icon-512-square.png "#0d1117"
python3 - "$LOGO" <<'PY'
import sys
from PIL import Image
d = sys.argv[1]
Image.open(f"{d}/icon-512-square.png").convert("RGB").save(f"{d}/icon-512.jpg", quality=95)
PY
rm "$LOGO/icon-512-square.png"
echo "wrote assets/logo/icon-512.jpg (512x512)"
