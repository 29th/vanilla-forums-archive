#!/usr/bin/env bash
set -Eeuo pipefail

url="https://vanilla.29th.org/"
outdir="./html"

args=(
#   --spider                       # dry-run
  --mirror                       # recursive + time-stamping + keep dir structure
  --page-requisites              # pull CSS/JS/images used by each page
  --convert-links                # rewrite links for offline/local serving
  --adjust-extension             # save text/html as .html
  --no-parent                    # don’t walk up above the root
  --domains=vanilla.29th.org     # stay on this host
#   --wait=0.5 --random-wait       # be polite
  --restrict-file-names=unix     # clean filenames on disk
  --execute=robots=off           # ignore robots.txt
#   "--accept-regex=^https?://vanilla\.29th\.org($|/$|/discussions(/p[0-9]+)?$|/categories/[^?#/]+$|/discussion/[0-9]+/[^?#/]+$)"
  "--reject-regex=/(signin|register|entry|profile|messages|post|edit|delete|search|api|sso|dashboard|plugin|upload/avatar|activity|discussion/comment/[0-9]+)(/|\?|$)"
  "--directory-prefix=$outdir"
  "--continue"
)

wget "${args[@]}" "$url"
