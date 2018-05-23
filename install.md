# Installation

This are general instructions, for specific operating systems have a look below.

* Install the [love2d](https://love2d.org) engine.
  A version >= 11.1 is required.
* Get the wesnoth-love
  [directory](https://github.com/fendrin/wesnoth-love) from GitHub.
* Install the dependencies
  * [lua-lpeg](http://www.inf.puc-rio.br/~roberto/lpeg/)
  * [lua-penlight](https://github.com/stevedonovan/Penlight)
  * [lua-sec](https://github.com/brunoos/luasec)
* Start the game by executing the love engine with the path to the file or directory.

## Ubuntu
```shell
# love2d and dependencies of wesnoth-love
sudo add-apt-repository -y 'ppa:bartbes/love-stable'; sudo apt-get update;
sudo apt-get -y install love lua-penlight lua-lpeg lua-sec
# fetch from github
git clone https://github.com/fendrin/wesnoth-love.git wesnoth
cd wesnoth; git submodule init; git submodule update
# start the game
./wesnoth
