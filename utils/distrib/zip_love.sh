#!/bin/bash
# Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
# SPDX-License-Identifier: GPL-2.0+

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
DESTINATION_DIR=${DIR}/builds/
DESTINATION_FILEPATH=${DESTINATION_DIR}wesnoth.love
echo "Building ${DESTINATION_FILEPATH}"

mkdir -p $DESTINATION_DIR
rm -f $DESTINATION_FILEPATH

cd $DIR
cd ../../
zip -q -x ".travis.yml" -x "utils/*" -x "wesnoth-love*" -x "*.git*" -9 -r $DESTINATION_FILEPATH ./
