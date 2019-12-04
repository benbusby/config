#!/bin/bash

# Basic config setup for vim, tmux, bash, etc
# Still needs:
# - font
# - gitconfig setup
# - ?

bold=$(tput bold)
ital=$(tput sitm)
red='\033[0;31m'
green='\033[0;32m'
ltcyan='\033[0;96m'
yellow='\033[0;93m'
normal=$(tput sgr0)
nc='\033[0m'

BREAK="${yellow}====================================${nc}"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Pre-run set up
echo -e "Setting up..."

# Anomaly Mono font
wget -q https://raw.githubusercontent.com/benbusby/anomaly-mono/master/AnomalyMono.otf -P ./font/

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # Linux
    echo -e $BREAK
    echo -e "${green}${bold}Linux${nc} detected...${normal}\n"
    OS_FILE=/etc/os-release
    if [ -f "$OS_FILE" ]; then
        # Use package manager to install packages
        cat $OS_FILE
        source $OS_FILE
        echo ""
        if [ "$ID" == "ubuntu" ] || [ "$ID_LIKE" == "debian" ]; then
            sudo apt-get install neovim python3-venv python3-pip
        elif [ "$ID" == "arch" ]; then
            sudo pacman -S neovim python-pip
        elif [ "$ID" == "rhel" ]; then
            sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
            sudo yum install -y neovim python3-neovim
        fi
    else
        # Attempt building from source / other generic install methods
        echo -e "${bold}${red}Unknown distro!${normal}${nc}"
        echo -e "Attempting generic installs...\n"

        # Neovim
        echo -e "${bold}Neovim:${normal}"
        curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
        chmod u+x nvim.appimage
        ./nvim.appimage
        echo ""
    fi

    # CCat
    echo -e "${bold}CCat:${normal}"
    mkdir ccat
    cd ccat
    wget https://github.com/jingweno/ccat/releases/download/v1.1.0/linux-amd64-1.1.0.tar.gz
    tar -zxvf linux-amd64-1.1.0.tar.gz
    ln -s `pwd`/linux-amd64-1.1.0/ccat /usr/bin/ccat
    cd $SCRIPT_DIR

    # Font setup
    cp font/AnomalyMono.otf ~/.local/share/fonts/

    # TODO: Complete this
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    echo -e $BREAK
    echo -e "${green}${bold}macOS${nc} detected...${normal}\n"

    which -s brew
    if [[ $? != 0 ]]; then
        # Install Homebrew
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        brew update
    fi

    brew install neovim ccat git python3

    # Font setup
    cp font/AnomalyMono.otf ~/Library/Fonts/

    # TODO: Complete this
else
    echo "Not sure what this OS is..."
    # TODO: Manual install prompt?
fi

cd $SCRIPT_DIR
echo -e $BREAK
# TODO: Add/verify symlinking for tmux, vimrc, bashrc, etc
ln -s `pwd`/bashrc ~/.bashrc
ln -s `pwd`/vimrc ~/.vimrc
ln -s `pwd`/tmux.conf ~/.tmux.conf
source ~/.bashrc

# Neovim setup
ln -s ~/.vimrc ~/.config/nvim/init.vim

# Non OS specific setup:
#
# - Vundle
#
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
#
# - Git
#
echo -e "${bold}Git setup${normal}"
$SCRIPT_DIR/git-setup.sh

# Cleanup (remove all subfolders)
rm -r -- */
