#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0
# Renders the 1200x630 social cards from the HTML templates next to this
# script, with headless Chrome.
#
# Usage: tools/og/render.sh   (needs google-chrome or chromium)
set -euo pipefail
HERE=$(cd "$(dirname "$0")" && pwd)
ROOT=$(cd "$HERE/../.." && pwd)
CHROME=$(command -v google-chrome || command -v chromium || command -v chromium-browser)
render() { # template output
    "$CHROME" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 \
        --window-size=1200,630 --screenshot="$2" "file://$HERE/$1" 2>/dev/null
    echo "wrote ${2#"$ROOT"/}"
}
render home.html "$ROOT/og-card.png"
render open-tick.html "$ROOT/open-tick/og-card.png"
render open-crank.html "$ROOT/open-crank/og-card.png"
