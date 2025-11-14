#!/usr/bin/env bash
set -Eeuo pipefail

domain="vanilla.29th.org"
url="https://$domain/"
outdir="./html"

args=(
#   --spider                       # dry-run
  --mirror                       # recursive + time-stamping + keep dir structure
  --page-requisites              # pull CSS/JS/images used by each page
  --convert-links                # rewrite links for offline/local serving
  --no-parent                    # don’t walk up above the root
  --domains=$domain              # stay on this host
#   --wait=0.5 --random-wait       # be polite
  --restrict-file-names=unix     # clean filenames on disk
  --execute=robots=off           # ignore robots.txt
  "--reject-regex=/(signin|register|entry|profile|messages|post|edit|delete|search|api|sso|dashboard|plugin|upload/avatar|activity|discussion/comment/[0-9]+|https?/steamcommunity|https?/personnel)(/|\?|$)"
  "--directory-prefix=$outdir"
  "--continue"
)

wget "${args[@]}" "$url"
