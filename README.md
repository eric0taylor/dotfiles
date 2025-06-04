# dotfiles
branches:
* main - common info
* arch - for arch linux
* slinux - for simply linux

# Deploy
```bash
# TODO поменять ссылку на правильную
sh -c "$(wget -O- https://github.com/eric0taylor/dotfiles.git)" 
```
# Update dotfiles
```bash
dotfiles commit -m "<messege>"
dotfiles push -u origin <branch>
```