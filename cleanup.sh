# !/bin/bash
set -Eeuo pipefail

# Remove files named `\"%1$s\".html`
find ./html -type f -name '\\"%1$s\\".html' -delete

# Replace references wget missed with absolute URLs (starting with /)
find ./html -type f -name "*.html" -exec sed -i '' -E 's#https?://vanilla\.29th\.org(/)?#/#g' {} +

# Remove erroneously-created deeply nested files, e.g. discussion/30258/https/steamcommunity.com/profiles/765...
find ./html -type f | awk 'length($0) > 200' | grep -E 'steamcommunity|personnel\.29th\.org' | xargs rm -f

# Remove any empty directories left behind
find ./html -type d -empty -delete
