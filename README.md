Wesnoth for Löve [![LOVE](https://img.shields.io/badge/L%C3%96VE-11.1.0-EA316E.svg)](http://love2d.org/)
================
Port of [The Battle for Wesnoth](https://www.wesnoth.org) to the Love2d Engine.

It is still in early development and not playable at this time.


License
-------

W4L is licensed under the **GPLv2+**.

The distribution ships with several third party libraries,
have a closer look [here](
https://github.com/fendrin/wesnoth-love/blob/master/license.txt
) for their License and Copyright information.


Discord Server
--------------

Please feel free to join the public [Discord](https://discord.gg/x3Bmy7v) server to discuss Wesnoth for Löve.


Development Thread
------------------

Have a look at the Development [Thread](
https://forums.wesnoth.org/viewtopic.php?f=13&t=53148
) found on Wesnoth's Forums.


Installation
============

Players
-------

Sorry, there is no stable release yet.

Testers
-------

### Windows
Fetch the *wesnoth-love-win64.exe* of the [latest release](
https://github.com/fendrin/wesnoth-love/releases/latest/
) at github.<br>
The file is a self-extracting archive that should run on all Windows versions > XP.<br>
Double click for extraction, then double click the "wesnoth-love.exe" inside the extracted "wesnoth-love-win64" folder.<br>
Pure zip archives are also available.

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

Once downloaded and with the dependencies installed, a simple open click onto the wesnoth.love file in a filebrowser can be used to start the game on most systems.

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

Contribute
==========

W4L comes with a low profile regarding the entry demands.

### Human Skills
You need

* Basic understanding of git and github
* Language Skills
  * _Lua_ 5.1
  * _Moonscript_ 0.5 (very similar to Lua)

Contributions in both, Lua or Moonscript will be accepted,
although the Lua ones might be translated into Moonscript at a later time.

### Development Setup
* Text Editor preferable with Lua/Moonscript support.
* A development installation of W4L
* _Lua_ 5.1 (or luajit) with
  * _Busted_ unit test suite
  * _binop_ library
  * _moonscript_

### Hardware
* 1GB of extra hard drive space is more than enough for the whole setup.
* There is no extra demands to the cpu and ram than the requirements of the love2d engine itself.

### Coding Conventions
* W4L uses an indentation level of 4 whitespaces.
* Use _ldoc_-style comments to document non-trivial sections.
* It can't hurt to implement _busted_ unit tests.
* Prefer readability over optimizations.
* Naming Conventions
  * class: PascalCase
  * local variables/functions: snake_case
  * constants: ALL_CAPS

### Filename Extensions
* .lua
Files containing lua code.
* .moon
Files containing Moonscript code.
* .wsl
Wesnoth Script Language - Modified Moonscript with Macro support
* .wesnoth
A file containing an add-on for Wesnoth for Löve
* .love
A file containing a Löve Game (like W4L)
* .md
Markdown File - used for documentation

### Löve boot sequence
* Löve loads in boot.lua:
  * require "love"

* love.boot() called -- (1st xpcall in boot.lua)
  * Require love.filesystem
  (the only module that you can't disable in conf.lua, it's mandatory)
  * Parse command line arguments
  (they will reside in the global arg table)
  * Determine if game is fused or not
  * Set game identity
  * Early check whether main.lua or conf.lua exists or not
  (if not, then errors later with the game being badly packaged)

* love.init() called -- (2nd xpcall in boot.lua)
  * Create default configuration settings
  * Load in configuration settings from conf.lua if it exists
  (or if love.conf exists, even without conf.lua)
  * Require modules
  * Create event handlers
  * Check version (compatibility related)
  * Setup window (if window module is loaded)
  * Set first timestep
  * Require main.lua
  (Loads in the body of main.lua)
  * Error if game is badly packaged.

* love.run() called
-- (3rd xpcall in boot.lua (if using the default love.run))
  * seed löve's default PRNG
  * love.load(args) -- (Actual game startup... usually)
* loop:
  * poll events -- (other love.___ callback functions)
  * love.update(dt)
  * love.draw
  * sleep
