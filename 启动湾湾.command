#!/bin/zsh
cd "$(dirname "$0")"

if [ -d "/Applications/BayChicken.app" ]; then
  open "/Applications/BayChicken.app"
  exit 0
fi

APP=$(find release -maxdepth 4 -name "*.app" -type d 2>/dev/null | head -1)
if [ -n "$APP" ]; then
  open "$APP"
  exit 0
fi

if [ ! -x node_modules/.bin/electron ]; then
  echo "正在安装依赖…"
  ELECTRON_MIRROR="${ELECTRON_MIRROR:-https://npmmirror.com/mirrors/electron/}" npm install || exit 1
fi

node scripts/build.mjs || exit 1
exec ./node_modules/.bin/electron .
