# Installation

## Players

Sorry, there is no stable release yet.

## Testers

### Windows

Download the latest release from:
[GitHub](https://github.com/fendrin/wesnoth-love/releases/latest)
Fetch the "wesnoth-love-win32.exe" from the assets section for a self-extracting archive that should run on all Windows versions >= XP.
After extracting, double click the "wesnoth-love.exe" inside the extracted "wesnoth-love-win32" folder.

### Ubuntu
```shell
# love2d and dependencies of wesnoth-love
sudo add-apt-repository -y 'ppa:bartbes/love-stable'; sudo apt-get update
sudo apt-get -y install love lua-lpeg wget
# fetch from github
wget https://github.com/fendrin/wesnoth-love/releases/latest/assets/wesnoth.love
# start the game
love wesnoth.love
```
Once downloaded and with the dependencies installed, a simple open click onto the wesnoth.love file in a filebrowser can be used to start the game.

### MacOSX



## Developers

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
git clone --recursive https://github.com/fendrin/wesnoth-love.git wesnoth
# start the game
./wesnoth/wesnoth
```
