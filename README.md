Wesnoth for Löve [![LOVE](https://img.shields.io/badge/L%C3%96VE-11.1.0-EA316E.svg)](http://love2d.org/)
================
A port of the Wesnoth Game to the Love2d Engine.

It is still in early development and not playable at this time.

[Installation](https://github.com/fendrin/wesnoth-love/blob/master/install.md)
--------------

License
-------

W4L is licensed under the **GPLv2+**.

The distribution ships with several third party libraries,
have a closer look [here](
https://github.com/fendrin/wesnoth-love/blob/master/license.txt
) for their License and Copyright information.

Contribute
----------

Wesnoth for Löve comes with a low profile regarding the entry demands.

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
