#!/usr/bin/env bash

# main packages
yay -Sy vim neovim tmux zsh bat gparted gimp htop libreoffice-fresh wireshark-qt chromium discord vlc stow exa thefuck xclip --needed --noconfirm

# plasma
# yay -Sy plasma-wayland-session plasma-systemmonitor --needed --noconfirm

# gnome
yay -Sy gnome-terminal gnome-tweaks gnome-browser-connector flat-remix-gtk flat-remix-gnome thunar evolution --needed --noconfirm

# fonts
yay -Sy ttf-noto-nerd noto-color-emoji-fontconfig noto-fonts-emoji --needed --noconfirm

# extra packages
yay -Sy dotnet-runtime dotnet-sdk aspnet-runtime grub-customizer xournalpp rustup cargo lazygit --needed --noconfirm

# autorotation on tablet
yay -Sy iio-sensor-proxy --needed --noconfirm

# AUR packages
yay -Sy pazi spotify tty-clock tuxy-git members --needed --noconfirm

rustup default stable

# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &&
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting &&
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth 1 https://github.com/unixorn/fzf-zsh-plugin.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-zsh-plugin


# LunarVim
yay -Sy python-pynvim --needed --noconfirm
LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)


# dotfiles
rm ~/.bashrc; stow --no-folding bash
rm ~/.tmux.conf; stow --no-folding tmux
rm ~/.zshrc; stow --no-folding zsh
rm ~/.config/lvim/config.lua; stow --no-folding lvim




# extras
ln -s /mnt/SSD_DATA ~/SSD_DATA
