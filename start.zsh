#!/bin/zsh
sudo pacman -Suy
sudo pacman -Scc
clear


cd .config

git pull origin main

cd ~

clear

fastfetch

zsh
