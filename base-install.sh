sudo pacman -Syyu &&
sudo pacman -Sy pcmanfm vlc vim neovim bless hexedit cmake dconf-editor evolution flameshot gthumb gimp htop leafpad libreoffice-fresh wireshark-qt qbittorrent gnome-calculator gnome-system-monitor vim firefox chromium base-devel bsd-games virtualbox stow exa tmux thefuck dotnet-runtime dotnet-sdk tree --needed

# install yay
cd /opt &&
sudo git clone https://aur.archlinux.org/yay.git -o yay &&
sudo chown -R $USER:users yay &&
cd yay &&
makepkg -si &&

# install aur packages
yay -S obsidian processing android-studio balena-etcher burpsuite gobuster-git flutter spotify tty-clock tuxi-git members npiet pwncat steghide ventoy-bin virtualbox-ext-oracle wfuzz zsteg --needed

# vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &&
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting &&
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# dotfiles
cd ~ &&
git clone https://github.com:D4VIDB2/dotfiles.git .dotfiles &&
cd .dotfiles &&
stow bash &&
stow nvim &&
stow tmux &&
stow zsh
# stow i3
# stow polybar

# Change default gnome file manager
xdg-mime default pcmanfm.desktop inode/directory application/x-gnome-saved-search


# Update system time
sudo timedatectl set-local-rtc 1 &&
sudo timedatectl set-ntp 1 &&
sudo systemctl start ntpd &&
sudo systemctl enable ntpd &&
sudo timedatectl status &&
sudo ntpdate tik.cesnet.cz
