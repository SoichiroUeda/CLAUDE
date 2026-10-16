#!/bin/zsh
# slides.html の各スライドを 1080×1080 の PNG として ../完成/ に書き出す
# 使い方: zsh render.sh   （特定の1枚だけなら zsh render.sh 3）
cd "${0:A:h}"
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
URL="file://$(python3 -c 'import sys,urllib.parse;print(urllib.parse.quote(sys.argv[1]))' "$PWD/slides.html")"
mkdir -p ../完成
LIST=("$@"); (( $# )) || LIST=(1 2 3 4 5 6 7 8)
for i in $LIST; do
  "$CHROME" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 \
    --window-size=1080,1080 --virtual-time-budget=3000 \
    --screenshot="$PWD/../完成/$(printf %02d $i).png" "$URL?s=$i" 2>/dev/null
done
ls -1 ../完成
