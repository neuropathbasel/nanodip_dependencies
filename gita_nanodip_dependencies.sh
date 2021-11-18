#!/bin/bash
#
echo "This will push everything in "`pwd`" to GitHub..."
#git remote set-url origin git@github.com:neuropathbasel/X86_64_MinKNOW_GUI_4.3.26_install_script
git remote set-url origin git@github.com:neuropathbasel/nanodip_dependencies
git add -A
git commit -m "update"
git push
