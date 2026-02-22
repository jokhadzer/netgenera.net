#!/bin/bash
curl -fsSL https://nodejs.org/dist/v20.19.0/node-v20.19.0-linux-x64.tar.xz | tar -xJ
export PATH="$(pwd)/node-v20.19.0-linux-x64/bin:$PATH"
rm -rf themes/tailbliss
git clone --depth 1 https://github.com/nusserstudios/tailbliss.git themes/tailbliss
cd themes/tailbliss && npm install && npx vite build --mode production && cd ../..
npm install
hugo --baseURL "${CF_PAGES_URL:-/}"
npx wrangler pages project create netgenera --production-branch=main 2>/dev/null
npx wrangler pages deploy public --project-name=netgenera --commit-dirty=true
