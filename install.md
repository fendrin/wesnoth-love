# Installation

## General

This are general instructions, for specific operating systems have a look below.

* Install the [love2d](https://love2d.org) engine.
  A version >= 11.1 is required.
* Clone (recursive) the wesnoth-love
  [directory](https://github.com/fendrin/wesnoth-love)
  from GitHub.
* Install the dependencies
  * [lua-lpeg](http://www.inf.puc-rio.br/~roberto/lpeg/)
  * [lua-penlight](https://github.com/stevedonovan/Penlight)
* Start the game by executing the love engine with the path to the wesnoth-love directory as argument.

## Ubuntu
```shell
# love2d and dependencies of wesnoth-love
sudo add-apt-repository -y 'ppa:bartbes/love-stable'; sudo apt-get update
sudo apt-get -y install love lua-penlight lua-lpeg git
# fetch from github
git clone --recursive https://github.com/fendrin/wesnoth-love.git wesnoth
# start the game
./wesnoth/wesnoth
