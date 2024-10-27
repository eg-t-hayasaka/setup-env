#!/bin/bash

brew_path=`which brew`

if [ "x$brew_path" = 'x' ]; then
    echo "Install Homebrew."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
else
    echo "Homebrew already installed."
fi

ansible_path=`which ansible`

if [ "x$ansible_path" = 'x' ]; then
    echo "Install ansible & ansible-galaxy."
    brew update
    brew install ansible
    brew link ansible

    ansible-galaxy install hnakamur.homebrew-packages
    ansible-galaxy install hnakamur.homebrew-cask-packages
else
    echo "Ansible already installed."
fi

echo "Install applications."
ansible-playbook -i hosts playbook.yml

