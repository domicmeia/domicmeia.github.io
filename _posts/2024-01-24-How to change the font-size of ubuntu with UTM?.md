---
layout: post
category: Note
---

## How to change the font-size in Ubuntu Server 20.04 LTS

What I'm trying to do is increase the font size, not change the resolution. This is the terminal, there is no GUI installed.

Here is the solution:

```shell
sudoedit /etc/default/console-setup
```
and change the value of font-size like **FONTSIZE="16x32"**  
save the file and apply the change with:

```shell
sudo update-initramfs -u
sudo reboot
```