# !/bin/bash
set -Eeuo pipefail

echo 'Removing files named `\"%1$s\"`'
find ./html -type f -name '\\"%1$s\\"' -delete

echo 'Removing erroneously-created deeply nested files, e.g. discussion/30258/https/steamcommunity.com/profiles/765...'
find ./html -type f | awk 'length($0) > 200' | grep -E 'steamcommunity|personnel\.29th\.org' | xargs rm -f

echo 'Removing any empty directories left behind'
find ./html -type d -empty -delete

echo 'Converting bare files to directories with index.html (e.g. /discussion/12345 -> /discussion/12345/index.html)'
for f in `find ./html -type f ! -name '*.*'`
do
  if file --mime-type -b "$f" | grep -q 'text/html'; then
    dir="$f"
    tmp="${f}.tmp-move"

    echo "Converting $f -> $dir/index.html"

    mv "$f" "$tmp"              # 1. Move file out of the way
    mkdir -p "$dir"             # 2. Create directory now that name is free
    mv "$tmp" "$dir/index.html" # 3. Move file inside
  fi
done

echo 'Replacing references wget missed with absolute URLs (starting with /)'
find ./html -type f -name "*.html" -exec sed -i '' -E 's#https?://vanilla\.29th\.org(/)?#/#g' {} +

# echo 'Removing querystrings from filenames'
# for i in `find ./html -type f | grep ?`
# do
#     echo "Removing querystring from $i"
#     mv $i `echo $i | cut -d? -f1`
# done

echo 'Done!'
