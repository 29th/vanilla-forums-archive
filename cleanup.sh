# !/bin/bash
set -Eeuo pipefail

# Remove files named `\"%1$s\".html`
find ./html -type f -name '\\"%1$s\\".html' -delete

# Replace references wget missed with absolute URLs (starting with /)
find ./html -type f -name "*.html" -exec sed -i '' -E 's#https?://vanilla\.29th\.org(/)?#/#g' {} +
