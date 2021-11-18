#!/bin/bash
#
echo "This will push everything in "`pwd`" to GitHub..."
git remote set-url origin https://git@github.com/neuropathbasel/nanodip_dependencies
git add -A
git commit -m "update"
git push
