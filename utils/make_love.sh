#!/bin/bash
# Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
# SPDX-License-Identifier: GPL-2.0+

TOPLEVEL="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../"
utils_dir="${TOPLEVEL}utils/"
create_dir="${TOPLEVEL}utils/distrib/"
resources_dir="${TOPLEVEL}utils/resources/"
love_dir="${resources_dir}love/"
lpeg_dir="${resources_dir}lpeg/"
zipsfx_dir="${resources_dir}unzipsfx/"
deb_dir="${create_dir}deb/"
win_dir="${create_dir}win64/"
mac_dir="${create_dir}macOS/"

# todo source from a single point
w4l_ver="0.0.1"
love_ver="11.3"

####################### debian build
cd $utils_dir
dpkg-buildpackage -us -uc
mkdir -p $deb_dir
mv ${TOPLEVEL}wesnoth-love_* $deb_dir

# fetch the resources

## fetch love binaries
win_zip64=love-${love_ver}-win64.zip
mac_zip64=love-${love_ver}-macos.zip
win_dir64=${love_dir}love-${love_ver}-win64/
mac_dir64=${love_dir}love.app/
wget -nc -P $love_dir https://bitbucket.org/rude/love/downloads/$mac_zip64
wget -nc -P $love_dir https://bitbucket.org/rude/love/downloads/$win_zip64
unzip -n -q -d $love_dir ${love_dir}${mac_zip64}
unzip -n -q -d $love_dir ${love_dir}${win_zip64}

lpeg_src_win64=https://github.com/luapower/luapower-all/raw/master/bin/mingw64/clib/lpeg.dll
lpeg_src_macos=https://github.com/luapower/luapower-all/raw/master/bin/osx64/clib/lpeg.so
## fetch lpeg
wget -nc -P $lpeg_dir $lpeg_src_win64
wget -nc -P $lpeg_dir $lpeg_src_macos

## fetch zipsfx
unzip_src_win=ftp://ftp.info-zip.org/pub/infozip/win32/unz600xn.exe
unzip_src_macos=ftp://ftp.info-zip.org/pub/infozip/unix/freebsd/unz552x.zip
wget -nc -P $zipsfx_dir $unzip_src_win
unzip -n -q -d $zipsfx_dir ${zipsfx_dir}unz600xn.exe unzipsfx.exe
wget -nc -P $zipsfx_dir $unzip_src_macos
unzip -n -q -d $zipsfx_dir ${zipsfx_dir}unz552x.zip unzipsfx

#################### windows

## append the love file to the windows binary
cat ${win_dir64}love.exe ${create_dir}wesnoth.love > ${win_dir64}wesnoth-love.exe

# setup the windows dir
rm ${win_dir64}changes.txt ${win_dir64}readme.txt ${win_dir64}love.exe ${win_dir64}lovec.exe ${win_dir64}game.ico ${win_dir64}love.ico
mv ${win_dir64}license.txt ${win_dir64}license_love2d.txt
cp ${TOPLEVEL}README.md ${win_dir64}
cp ${TOPLEVEL}license.txt ${win_dir64}license_wesnoth.txt
cp ${lpeg_dir}lpeg.dll ${win_dir64}lpeg.dll

## move the dir to destination
mkdir -p $win_dir
mv $win_dir64 ${win_dir}wesnoth-love-${w4l_ver}-win64

## zip and prepare for self-extraction
cd $win_dir
zip -q -9 -r wesnoth-love-win64.zip wesnoth-love-${w4l_ver}-win64
cat ${zipsfx_dir}unzipsfx.exe wesnoth-love-win64.zip > wesnoth-love-win64.exe
zip -A wesnoth-love-win64.exe

################ macOS
## copy the love file
cp ${create_dir}wesnoth.love ${mac_dir64}Contents/Resources/wesnoth-love.love
cp ${utils_dir}Info.plist $mac_dir64/Contents/Info.plist
cp ${lpeg_dir}lpeg.so ${mac_dir64}Contents/MacOS/lpeg.so

## move the dir to destination
mkdir -p $mac_dir
mv $mac_dir64 ${mac_dir}wesnoth-love-${w4l_ver}.app

## zip and prepare for self-extraction
cd ${mac_dir}
zip -q -9 -r -y wesnoth-love-macos.zip wesnoth-love-${w4l_ver}.app
cat ${zipsfx_dir}unzipsfx wesnoth-love-macos.zip > wesnoth-love-macos.exe
zip -A wesnoth-love-macos.exe
