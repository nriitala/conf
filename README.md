## Notes
*Don't just blindly copy these files, you should review them first. There's some rather idiosyncratic stuff in here.*
Some background information about my system:
I'm using Xubuntu without xfdesktop and xfce-panel and with i3 window manager (deb http://debian.sur5r.net/i3/). Trying to benefit from desktop environment (essential power saving tools etc. for laptop) but keep it as minimalistic and efficient as possible without actual graphical user interface.

## main files

### .vimrc
- my .vimrc file, optimized for PHP, used with non-bsd Linux

### .zshrc
- my Z shell config

### .screenrc
- screen config file with neat statusbar and initialized set of windows

### .gitignore
- drupal and vim compatible .gitignore file

### .htoprc
- config file for htop, some basic settings, nothing important

### .pentadactylrc
- just some mappings for [Pentadactyl](http://5digits.org/pentadactyl/)

## some scripts

### scripts/manage-vim-backups.sh
- used to clean old backups (~/.vim-backup), see .vimrc

### scripts/diffconflicts
- manage diff conflicts with less PITA, see .gitconfig

### scripts/spotify-control.sh
- quick messy fork of script using spotify from terminal
