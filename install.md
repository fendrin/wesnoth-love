Installation
============

Players
-------

Sorry, there is no stable release yet.

Testers
-------

### Windows
Fetch the *wesnoth-love-win32.exe* of the [latest release](
https://github.com/fendrin/wesnoth-love/releases/latest/
) at github.<br>
The file is a self-extracting archive that should run on all Windows versions >= XP.<br>
Double click for extraction, then double click the "wesnoth-love.exe" inside the extracted "wesnoth-love-win32" folder.<br>
Pure zip archives and 64-bit version are also available.

### Ubuntu
```shell
# love2d and dependencies of wesnoth-love
sudo add-apt-repository -y 'ppa:bartbes/love-stable'; sudo apt-get update
sudo apt-get -y install love lua-lpeg
```
Fetch the *wesnoth-love_all.deb* of the [latest release](
https://github.com/fendrin/wesnoth-love/releases/latest/
) at github.

```shell
sudo dpkg -i wesnoth-love_all.deb
# start the game
wesnoth-love
```
Once downloaded and with the dependencies installed, a simple open click onto the wesnoth.love file in a filebrowser can be used to start the game.

### MacOSX

Fetch the *wesnoth-love-macos.zip* of the [latest release](
https://github.com/fendrin/wesnoth-love/releases/latest/
) at github.<br>
unzip and then TODO

Developers
----------

### General

This are general instructions, for specific operating systems have a look below.

* Install the [love2d](https://love2d.org) engine.
  A version >= 11.1 is required.
* Clone (recursive) the wesnoth-love
  [directory](https://github.com/fendrin/wesnoth-love)
  from GitHub.
* Install the dependencies
  * [lua-lpeg](http://www.inf.puc-rio.br/~roberto/lpeg/)
* Start the game by executing the love engine with the path to the wesnoth-love directory as argument.

### Ubuntu
```shell
# love2d and dependencies of wesnoth-love
sudo add-apt-repository -y 'ppa:bartbes/love-stable'; sudo apt-get update
sudo apt-get -y install love lua-lpeg git
# fetch from github
git clone --recursive https://github.com/fendrin/wesnoth-love.git
# start the game
./wesnoth-love/wesnoth-love
```
[Howl](https://howl.io/) is a decent editor with Lua/Moonscript support.
