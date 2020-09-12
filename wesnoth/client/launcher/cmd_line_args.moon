
{
    {
        {
            long: "clock"
            description: "Adds the option to show a clock for testing the drawing timer."
        }
        {
            long: "config-dir"
            arg: true
            description: "sets the path of the userdata directory to $HOME/<arg> or My Documents\\My Games\\<arg> for Windows. You can specify also an absolute path outside the $HOME or My Documents\\My Games directory. DEPRECATED: use userdata-path and userconfig-path instead."
        }
        {
            long: "config-path"
            description: "prints the path of the userdata directory and exits. DEPRECATED: use userdata-path and userconfig-path instead."
        }
        {
            long: "core"
            arg: true
            description: "overrides the loaded core with the one whose id is specified."
        }
        {
            long: "data-dir"
            arg: true
            description: "overrides the data directory with the one specified."
        }
        {
            long: "data-path"
            description: "prints the path of the data directory and exits."
        }
        {
            short: 'd'
            long: "debug"
            description: "enables additional command mode options in-game."
        }
        {
            long: "debug-lua"
            description: "enables some Lua debugging mechanisms"
        }
        {
            short: 'e'
            long: "editor"
            arg: true
            description: "starts the in-game map editor directly. If file <arg> is specified, equivalent to -e --load <arg>."
        }
        {
            short: 'h'
            long: "help"
            description: "prints this message and exits."
        }
        {
            short: 'L'
            long: "language"
            arg: true
            description: "uses language <arg> (symbol) this session. Example: --language ang_GB@latin"
        }
        {
            short: 'l'
            long: 'load'
            arg: true
            description: "loads the save <arg> from the standard save game directory. When launching the map editor via -e, the map <arg> is loaded, relative to the current directory. If it is a directory,  the editor will start with a load map dialog opened there."
        }
        {
            long: "noaddons"
            description: "disables the loading of all add-ons."
        }
        {
            long: "nocache"
            description: "disables caching of game data."
        }
        {
            long: "nodelay"
            description: "runs the game without any delays."
        }
        {
            long: "nomusic"
            description: "runs the game without music."
        }
        {
            long: "nosound"
            description: "runs the game without sounds and music."
        }
        {
            long: "path"
            description: "prints the path to the data directory and exits."
        }
        --plugin arg    (experimental) load a script which defines a wesnoth plugin. similar to --script below, but lua file should return a function which will be run as a coroutine and periodically woken up with updates.
        --render-image arg              takes two arguments: <image> <output>. Like screenshot, but instead of a map, takes a valid wesnoth 'image path string' with image path functions, and outputs to a windows .bmp file.
        --rng-seed arg                  seeds the random number generator with number <arg>. Example: --rng-seed 0
        --screenshot arg                takes two arguments: <map> <output>. Saves a screenshot of <map> to <output> without initializing a screen. Editor must be compiled in for this to work.
        --script arg                    (experimental) file containing a lua script to control the client
        --unsafe-scripts                makes the 'package' package available to lua scripts, so that they can load arbitrary packages. Do not do this with untrusted scripts! This action gives lua the same  permissions as the wesnoth executable.
        {
            short: 's'
            long: "server"
            arg: true
            description: "connects to the host <arg> if specified or to the first host in your preferences."
        }
        {
            long: "username"
            arg: true
            description: "uses <username> when connecting to a server, ignoring other preferences."
        }
        {
            long: "password"
            arg: true
            description: "uses <password> when connecting to a server, ignoring other preferences."
        }
        {
            long: "strict-validation"
            description: "makes validation errors fatal"
        }
        {
            long: "userconfig-dir"
            arg: true
            -- description: "sets the path of the user config directory to $HOME/<arg> or My Documents\My Games\<arg> for Windows. You can specify also an absolute path outside the $HOME or My Documents\My Games directory. Defaults to $HOME/.config/wesnoth on X11 and to the userdata-dir on other systems."
        }
          --userconfig-path               prints the path of the user config directory and exits.
          --userdata-dir arg              sets the path of the userdata directory to $HOME/<arg> or My Documents\My Games\<arg> for Windows. You can specify also an absolute path outside the $HOME or My Documents\My Games directory.
          --userdata-path                 prints the path of the userdata directory and exits.
        {
            long: "validcache"
            description: "assumes that the cache is valid. (dangerous)"
        }
        {
            short: 'v'
            long: "version"
            description: "prints the game's version number and exits."
        }
        {
            long: "with-replay"
            description: "replays the file loaded with the --load option."
        }
    }
    {
        description: "Campaign options:"
        {
            short: 'c'
            long: "campaign"
            arg: true
            description: "goes directly to the campaign with id <arg>. A selection menu will appear if no id was specified."
        }
        {
            long: "campaign-difficulty"
            arg: true
            description: "The difficulty of the specified campaign (1 to max). If none specified, the campaign difficulty selection widget will appear."
        }
        {
            long: "campaign-scenario"
            arg: true
            description: "The id of the scenario from the specified campaign. The default is the first scenario."
        }
    }
    {
        description: "Display options:"
        {
            long: "fps"
            description: "displays the number of frames per second the game is currently running at, in a corner of the screen."
        }
        {
            long: "fullscreen"
            short: 'f'
            description: "runs the game in full screen mode."
        }
        --max-fps arg        the maximum fps the game tries to run at. Values should be between 1 and 1000, the default is 50.
        {
            long: "resolution"
            short: 'r'
            arg: true
            description: "sets the screen resolution. <arg> should have format XxY. Example: --resolution 800x600"
        }
        {
            long: "windowed"
            short: 'w'
            description: "runs the game in windowed mode."
        }
    }
    {
        description: "Logging options:"
        --logdomains arg                lists defined log domains (only the ones containing <arg> filter if such is provided) and exits.
        --log-error arg    sets the severity level of the specified log domain(s) to 'error'. <arg> should be given as comma separated list of domains, wildcards are allowed. Example: --log-error=network,gui
--             /*,engine/enemies
        --log-warning arg               sets the severity level of the specified log domain(s) to 'warning'. Similar to --log-error.
        --log-info arg                  sets the severity level of the specified log domain(s) to 'info'. Similar to --log-error.
        --log-debug arg                 sets the severity level of the specified log domain(s) to 'debug'. Similar to --log-error.
        --log-precise                   shows the timestamps in the logfile with more precision.
    }
    {
        description: "Multiplayer options:"
        {
            short: 'm'
            long: "multiplayer"
            description: "Starts a multiplayer game. There are additional options that can be used as explained below:"
        }
        --ai-config arg                 selects a configuration file to load for this side. <arg> should have format side:value
        --algorithm arg                 selects a non-standard algorithm to be used by the AI controller for this side. <arg> should have format side:value
        --controller arg                selects the controller for this side. <arg> should have format side:value
        --era arg                       selects the era to be played in by its id.
        {
            long: "exit-at-end"
            description: "exit Wesnoth at the end of the scenario."
        }
        {
            long: "ignore-map-settings"
            description: "do not use map settings."
        }
        --label arg                     sets the label for AIs.
        {
            long: "multiplayer-repeat"
            arg: true
            description: "repeats a multiplayer game after it is finished <arg> times."
        }
        {
            long: "nogui"
            description: "runs the game without the GUI."
        }
        {
            long: "parm"
            arg: true
            description: "sets additional parameters for this side. <arg> should have format side:name:value."
        }
        {
            long: "scenario"
            arg: true
            description: 'selects a multiplayer scenario. The default scenario is "multiplayer_The_Freelands".'
        }
        {
            long: "side"
            arg: true
            description: "selects a faction of the current era for this side by id. <arg> should have format side:value."
        }
        {
            long: "turns"
            arg: true
            description: 'sets the number of turns. The default is "50".'
        }
    }
    {
        description: "Testing options:"
        {
            long: "test"
            short: 't'
            arg: true
            description: "runs the game in a small test scenario. If specified, scenario <arg> will be used instead."
        }
        {
            short: 'u'
            long: "unit"
            arg: true
            description: "runs a unit test scenario. Works like test, except that the exit code of the program reflects the victory / defeat conditions of the scenario.
                                  0 - PASS
                                  1 - FAIL
                                  2 - FAIL (TIMEOUT)
                                  3 - FAIL (INVALID REPLAY)
                                  4 - FAIL (ERRORED REPLAY)"
        }
        {
            long: "showgui"
            description: "don't run headlessly (for debugging a failing test)"
        }
        {
            long: "timeout"
            arg: true
            description: "sets a timeout (milliseconds) for the unit test. (DEPRECATED)"
        }
        {
            long: "log-strict"
            arg: true
            description: "sets the strict level of the logger. any messages sent to log domains of this level or more severe will cause the unit test to fail regardless of the victory result."
        }
        {
            long: "noreplaycheck"
            description: "don't try to validate replay of unit test."
        }
        {
            long: "mp-test"
            description: "load the test mp scenarios."
        }
    }
    {
        description: "Proxy options:"
        {
            long: "proxy"
            description: "enables usage of proxy for network connections."
        }
        {
            long: "proxy-address"
            arg: true
            description: "specifies address of the proxy."
        }
        {
            long: "proxy-port"
            arg: true
            description: "specifies port of the proxy."
        }
        {
            long: "proxy-user"
            arg: true
            description: "specifies username to log in to the proxy."
        }
        {
            long: "proxy-password"
            arg: true
            description: "specifies password to log in to the proxy."
        }
    }
}

-- Battle for Wesnoth v1.13.8
-- Started on Wed Dec  6 08:04:35 2017

-- Usage: wesnoth [<options>] [<data-directory>]

-- General options:
--   --bunzip2 arg                   decompresses a file (<arg>.bz2) in bzip2
--                                   format and stores it without the .bz2 suffix.
--                                   <arg>.bz2 will be removed.
--   --bzip2 arg                     compresses a file (<arg>) in bzip2 format,
--                                   stores it as <arg>.bz2 and removes <arg>.
--   --clock                         Adds the option to show a clock for testing
--                                   the drawing timer.
--   --config-dir arg                sets the path of the userdata directory to
--                                   $HOME/<arg> or My Documents\My Games\<arg>
--                                   for Windows. You can specify also an absolute
--                                   path outside the $HOME or My Documents\My
--                                   Games directory. DEPRECATED: use
--                                   userdata-path and userconfig-path instead.
--   --config-path                   prints the path of the userdata directory and
--                                   exits. DEPRECATED: use userdata-path and
--                                   userconfig-path instead.
--   --core arg                      overrides the loaded core with the one whose
--                                   id is specified.
--   --data-dir arg                  overrides the data directory with the one
--                                   specified.
--   --data-path                     prints the path of the data directory and
--                                   exits.
--   -d [ --debug ]                  enables additional command mode options
--                                   in-game.
--   --debug-lua                     enables some Lua debugging mechanisms
--   -e [ --editor ] arg             starts the in-game map editor directly. If
--                                   file <arg> is specified, equivalent to -e
--                                   --load <arg>.
--   --gunzip arg                    decompresses a file (<arg>.gz) in gzip format
--                                   and stores it without the .gz suffix.
--                                   <arg>.gz will be removed.
--   --gzip arg                      compresses a file (<arg>) in gzip format,
--                                   stores it as <arg>.gz and removes <arg>.
--   -h [ --help ]                   prints this message and exits.
--   -L [ --language ] arg           uses language <arg> (symbol) this session.
--                                   Example: --language ang_GB@latin
--   -l [ --load ] arg               loads the save <arg> from the standard save
--                                   game directory. When launching the map editor
--                                   via -e, the map <arg> is loaded, relative to
--                                   the current directory. If it is a directory,
--                                   the editor will start with a load map dialog
--                                   opened there.
--   --noaddons                      disables the loading of all add-ons.
--   --nocache                       disables caching of game data.
--   --nodelay                       runs the game without any delays.
--   --nomusic                       runs the game without music.
--   --nosound                       runs the game without sounds and music.
--   --path                          prints the path to the data directory and
--                                   exits.
--   --plugin arg                    (experimental) load a script which defines a
--                                   wesnoth plugin. similar to --script below,
--                                   but lua file should return a function which
--                                   will be run as a coroutine and periodically
--                                   woken up with updates.
--   --render-image arg              takes two arguments: <image> <output>. Like
--                                   screenshot, but instead of a map, takes a
--                                   valid wesnoth 'image path string' with image
--                                   path functions, and outputs to a windows .bmp
--                                   file.
--   --rng-seed arg                  seeds the random number generator with number
--                                   <arg>. Example: --rng-seed 0
--   --screenshot arg                takes two arguments: <map> <output>. Saves a
--                                   screenshot of <map> to <output> without
--                                   initializing a screen. Editor must be
--                                   compiled in for this to work.
--   --script arg                    (experimental) file containing a lua script
--                                   to control the client
--   --unsafe-scripts                makes the 'package' package available to lua
--                                   scripts, so that they can load arbitrary
--                                   packages. Do not do this with untrusted
--                                   scripts! This action gives lua the same
--                                   permissions as the wesnoth executable.
--   -s [ --server ] arg             connects to the host <arg> if specified or to
--                                   the first host in your preferences.
--   --username arg                  uses <username> when connecting to a server,
--                                   ignoring other preferences.
--   --password arg                  uses <password> when connecting to a server,
--                                   ignoring other preferences.
--   --strict-validation             makes validation errors fatal
--   --userconfig-dir arg            sets the path of the user config directory to
--                                   $HOME/<arg> or My Documents\My Games\<arg>
--                                   for Windows. You can specify also an absolute
--                                   path outside the $HOME or My Documents\My
--                                   Games directory. Defaults to
--                                   $HOME/.config/wesnoth on X11 and to the
--                                   userdata-dir on other systems.
--   --userconfig-path               prints the path of the user config directory
--                                   and exits.
--   --userdata-dir arg              sets the path of the userdata directory to
--                                   $HOME/<arg> or My Documents\My Games\<arg>
--                                   for Windows. You can specify also an absolute
--                                   path outside the $HOME or My Documents\My
--                                   Games directory.
--   --userdata-path                 prints the path of the userdata directory and
--                                   exits.
--   --validcache                    assumes that the cache is valid. (dangerous)
--   -v [ --version ]                prints the game's version number and exits.
--   --with-replay                   replays the file loaded with the --load
--                                   option.
--
-- Campaign options:
--   -c [ --campaign ] arg           goes directly to the campaign with id <arg>.
--                                   A selection menu will appear if no id was
--                                   specified.
--   --campaign-difficulty arg       The difficulty of the specified campaign (1
--                                   to max). If none specified, the campaign
--                                   difficulty selection widget will appear.
--   --campaign-scenario arg         The id of the scenario from the specified
--                                   campaign. The default is the first scenario.
--
-- Display options:
--   --fps                           displays the number of frames per second the
--                                   game is currently running at, in a corner of
--                                   the screen.
--   -f [ --fullscreen ]             runs the game in full screen mode.
--   --max-fps arg                   the maximum fps the game tries to run at.
--                                   Values should be between 1 and 1000, the
--                                   default is 50.
--   --new-widgets                   there is a new WIP widget toolkit this switch
--                                   enables the new toolkit (VERY EXPERIMENTAL
--                                   don't file bug reports since most are known).
--                                   Parts of the library are deemed stable and
--                                   will work without this switch.
--   -r [ --resolution ] arg         sets the screen resolution. <arg> should have
--                                   format XxY. Example: --resolution 800x600
--   -w [ --windowed ]               runs the game in windowed mode.
--
-- Logging options:
--   --logdomains arg                lists defined log domains (only the ones
--                                   containing <arg> filter if such is provided)
--                                   and exits.
--   --log-error arg                 sets the severity level of the specified log
--                                   domain(s) to 'error'. <arg> should be given
--                                   as comma separated list of domains, wildcards
--                                   are allowed. Example: --log-error=network,gui
--                                   /*,engine/enemies
--   --log-warning arg               sets the severity level of the specified log
--                                   domain(s) to 'warning'. Similar to
--                                   --log-error.
--   --log-info arg                  sets the severity level of the specified log
--                                   domain(s) to 'info'. Similar to --log-error.
--   --log-debug arg                 sets the severity level of the specified log
--                                   domain(s) to 'debug'. Similar to --log-error.
--   --log-precise                   shows the timestamps in the logfile with more
--                                   precision.
--
-- Multiplayer options:
--   -m [ --multiplayer ]            Starts a multiplayer game. There are
--                                   additional options that can be used as
--                                   explained below:
--   --ai-config arg                 selects a configuration file to load for this
--                                   side. <arg> should have format side:value
--   --algorithm arg                 selects a non-standard algorithm to be used
--                                   by the AI controller for this side. <arg>
--                                   should have format side:value
--   --controller arg                selects the controller for this side. <arg>
--                                   should have format side:value
--   --era arg                       selects the era to be played in by its id.
--   --exit-at-end                   exit Wesnoth at the end of the scenario.
--   --ignore-map-settings           do not use map settings.
--   --label arg                     sets the label for AIs.
--   --multiplayer-repeat arg        repeats a multiplayer game after it is
--                                   finished <arg> times.
--   --nogui                         runs the game without the GUI.
--   --parm arg                      sets additional parameters for this side.
--                                   <arg> should have format side:name:value.
--   --scenario arg                  selects a multiplayer scenario. The default
--                                   scenario is "multiplayer_The_Freelands".
--   --side arg                      selects a faction of the current era for this
--                                   side by id. <arg> should have format
--                                   side:value.
--   --turns arg                     sets the number of turns. The default is
--                                   "50".
--
-- Testing options:
--   -t [ --test ] arg               runs the game in a small test scenario. If
--                                   specified, scenario <arg> will be used
--                                   instead.
--   -u [ --unit ] arg               runs a unit test scenario. Works like test,
--                                   except that the exit code of the program
--                                   reflects the victory / defeat conditions of
--                                   the scenario.
--                                   0 - PASS
--                                   1 - FAIL
--                                   2 - FAIL (TIMEOUT)
--                                   3 - FAIL (INVALID REPLAY)
--                                   4 - FAIL (ERRORED REPLAY)
--   --showgui                       don't run headlessly (for debugging a failing
--                                   test)
--   --timeout arg                   sets a timeout (milliseconds) for the unit
--                                   test. (DEPRECATED)
--   --log-strict arg                sets the strict level of the logger. any
--                                   messages sent to log domains of this level or
--                                   more severe will cause the unit test to fail
--                                   regardless of the victory result.
--   --noreplaycheck                 don't try to validate replay of unit test.
--   --mp-test                       load the test mp scenarios.
--
-- Preprocessor mode options:
--   -p [ --preprocess ] arg         requires two arguments: <file/folder> <target
--                                   directory>. Preprocesses a specified
--                                   file/folder. The preprocessed file(s) will be
--                                   written in the specified target directory: a
--                                   plain cfg file and a processed cfg file.
--   --preprocess-defines arg        comma separated list of defines to be used by
--                                   '--preprocess' command. If 'SKIP_CORE' is in
--                                   the define list the data/core won't be
--                                   preprocessed. Example: --preprocess-defines=F
--                                   OO,BAR
--   --preprocess-input-macros arg   used only by the '--preprocess' command.
--                                   Specifies source file <arg> that contains
--                                   [preproc_define]s to be included before
--                                   preprocessing.
--   --preprocess-output-macros arg  used only by the '--preprocess' command. Will
--                                   output all preprocessed macros in the target
--                                   file <arg>. If the file is not specified the
--                                   output will be file '_MACROS_.cfg' in the
--                                   target directory of preprocess's command.
--
-- Proxy options:
--   --proxy                         enables usage of proxy for network
--                                   connections.
--   --proxy-address arg             specifies address of the proxy.
--   --proxy-port arg                specifies port of the proxy.
--   --proxy-user arg                specifies username to log in to the proxy.
--   --proxy-password arg            specifies password to log in to the proxy.

