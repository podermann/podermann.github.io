#!/bin/sh
id -u | grep -qx 0 || exit


alias u="sudo -u user bash -c"
installgit() 
{
	url=$1
	name=$(echo $url | pcregrep -o1 '/([\d\w]*)[/]?$')
	u "git clone $url" || return
	cd $name
	make install
	cd ..
}

installaur() 
{
	url="https://aur.archlinux.org/$1"
	name=$1
	u "git clone $url" || return
	cd $name
	u 'makepkg -si --noconfirm'
	cd ..
}

#echo "enter name:"
#read username

pacman -Syu --noconfirm --needed xorg-server xorg-xinit xorg-xsetroot slock xf86-video-intel xorg-xbacklight neovim git libxinerama libxft libx11 mpv ffmpeg yt-dlp alsa-utils powertop sxhkd thermald termdown man-db man-pages neofetch archlinux-keyring powertop bc openssh virt-viewer calcurse redshift jq dash sxiv fzfpolybar ttf-roboto-mono

#useradd -mG wheel $username
#echo "$username	ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers.d/

home=$(sudo -u user bash -c 'echo $HOME')
src=$home/.local/src
bin=$home/.local/bin
u "mkdir -p $src"
u "mkdir -p $bin"

cd $src
pwd


<<done
installgit https://git.suckless.org/dwm
installgit https://git.suckless.org/st
installgit https://git.suckless.org/dmenu

installaur yay 

u 'yay -S --noconfirm --needed librewolf-bin apulse lf-bin'

u 'cp /etc/X11/xinit/xinitrc ~/.xinitrc'
done
