#!/bin/bash
# Git credential setup

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cp $SCRIPT_DIR/gitconfig ~/.gitconfig
read -p "Name (first and last): " gitname
read -p "Email address: " gitemail
sed -i "s/GITNAME/$gitname/g" ~/.gitconfig
sed -i "s/GITEMAIL/$gitemail/g" ~/.gitconfig
