#!/bin/bash
# Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
# SPDX-License-Identifier: GPL-2.0+

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
DESTINATION_DIR=${DIR}/builds/
DESTINATION_FILEPATH=${DESTINATION_DIR}wesnoth.love
echo $DIR
echo $DESTINATION_DIR
echo $DESTINATION_FILEPATH

mkdir $DESTINATION_DIR
rm $DESTINATION_FILEPATH

cd DIR
cd ../../
zip -x ".travis.yml" -x "utils/*" -x "wesnoth-love*" -x "*.git*" -9 -r ${DESTINATION_DIR}wesnoth.love ./
