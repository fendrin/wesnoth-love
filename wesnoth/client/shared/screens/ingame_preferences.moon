----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


Preferences = require'shared.screens.preferences'
preferences = require'preferences'


class ConfiguratorPreferences extends Preferences

    handler: (item, value) =>
        super(item, value)
        switch item
            when 'close'
                if value
                    preferences.apply!

