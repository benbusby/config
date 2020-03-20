#!/bin/bash

# Basic config setup for vim, tmux, bash, git, etc

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

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # Linux
    echo -e $BREAK
    echo -e "${green}${bold}Linux${nc} detected...${normal}\n"
    OS_FILE=/etc/os-release
    if [[ -f "$OS_FILE" ]]; then
        # Use package manager to install packages
        cat $OS_FILE
        source $OS_FILE
        echo ""
        if [[ "$ID" == "ubuntu" ]] || [[ "$ID_LIKE" == "debian" ]]; then
            sudo apt-get install neovim python3-venv python3-pip tree jq git
        elif [[ "$ID_LIKE" == "arch" ]]; then
            sudo pacman -S neovim python-pip tree jq git
        elif [[ "$ID" == "rhel" ]]; then
            sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
            sudo yum install -y neovim python3-neovim tree jq git
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
    if [[ ! -f "/usr/bin/ccat" ]]; then
        echo -e "${bold}CCat:${normal}"
        mkdir ccat
        cd ccat
        wget https://github.com/jingweno/ccat/releases/download/v1.1.0/linux-amd64-1.1.0.tar.gz
        tar -zxvf linux-amd64-1.1.0.tar.gz
        sudo mv `pwd`/linux-amd64-1.1.0/ccat /usr/bin/ccat
        cd $SCRIPT_DIR
    fi

    # Font setup
    if [[ -d "~/.local/share/fonts" ]] && [[ "$1" == "--include-font" ]]; then
        wget -q https://raw.githubusercontent.com/benbusby/anomaly-mono/master/AnomalyMono.otf -P ~/.local/share/fonts/
    fi
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

    if [[ "$1" == "--include-font" ]]; then
        wget -q https://raw.githubusercontent.com/benbusby/anomaly-mono/master/AnomalyMono.otf -P ~/Library/Fonts
    fi

    # TODO: Complete this
else
    echo "Not sure what this OS is..."
    # TODO: Manual install prompt?
fi

cd $SCRIPT_DIR
echo -e $BREAK

read -p "Remove existing rc files and update? (y/n) " yn
case $yn in
    [Yy]* )
        rm ~/.bashrc ~/.vimrc ~/.tmux.conf
        ln -s `pwd`/bashrc ~/.bashrc
        ln -s `pwd`/vimrc ~/.vimrc
        ln -s `pwd`/tmux.conf ~/.tmux.conf
        ;;
    [Nn]* )
        ;;
esac


# Neovim setup
mkdir -p ~/.config/nvim/
rm -f ~/.config/nvim/init.vim
ln -s ~/.vimrc ~/.config/nvim/init.vim

# Non OS specific setup:
#
# - Vundle
#
if [[ ! -d "~/.vim/bundle/Vundle.vim" ]]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

vim +PluginInstall +qall
rm -f ~/extend-syntax.vim
ln -s ~/.vim/bundle/earthbound-themes/vim/extend-syntax.vim ~

#
# - Git
#
echo -e "$BREAK"
echo -e "${bold}Git setup${normal}\n"
$SCRIPT_DIR/git-setup.sh

git clone --depth=1 https://github.com/romkatv/gitstatus.git ~/gitstatus
cp $SCRIPT_DIR/gitstatus.prompt.sh ~/gitstatus/gitstatus.prompt.sh

# Cleanup (remove all subfolders)
rm -r -- */

echo -e "$BREAK\n"
echo -e "${bold}${green}All done!${normal}${nc}"

source ~/.bashrc
