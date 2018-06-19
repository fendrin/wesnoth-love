moonscript = require"moonscript"

-- Penlight lib requires
import setfenv from require"pl.utils"

get = require"shared.filesystem"
LOG_FS = (require"log")"filesystem"

love = love
fs = love.filesystem

enabled = fs.areSymlinksEnabled!
LOG_FS.debug"Do we follow symlinks? #{enabled}"

try = require"try"

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- File/directory inclusions
--
-- Syntax: {path}
--
-- Includes the file with the specified path, which will in turn run the preprocessor on it and perform any required substitutions or inclusions within it.
-- The path may not contain .. or the inclusion will be skipped.
--
-- The exact location in which the path will be resolved will depend on its prefix:
--
-- {path}: If path isn't a known macro (see below), the game will assume it's a relative path to a file in the main game data/ directory and include it.
-- {~path}: As above, but instead of the game data directory, the path is resolved relative to the user data/ directory, where user made add-ons can normally be found.
-- {./path}: The path is resolved relative to the location of the current file containing this inclusion.
--
-- Information for locating the user data and game data directories can be found in EditingWesnoth.
--
-- Forward slashes (/) should always be used as the path delimiter, even if your platform uses a different symbol such as colons (:) or backslashes (\)!
-- It is also very important to respect the actual letter case used to name files and directories for compatibility with case-sensitive filesystems on Unix-based operating systems.
--
-- When path points to a directory instead of a file, the preprocessor will include all files found within with the .cfg extension, in alphabetical order;
-- files without this extension (such as .map or .png files) are ignored.
--
-- Some directories are handled in a special fashion according to their contents:
--
-- If there's a file named _main.cfg in the target directory, only that file will be included and preprocessed.
-- It may include other files from its own directory or subdirectories within it, of course.
-- This is used for managing WML directories as self-contained packages, like user made add-ons.
-- If there are files named _main.cfg in subdirectories of the target and there isn't one in the target itself, they will be all preprocessed. Given the following layout:
--
-- dir/
-- dir/a/_main.cfg
-- dir/a/other.cfg
-- dir/b/_main.cfg
-- dir/b/other.cfg
-- dir/other.cfg
--
-- Using {dir} will cause dir/a/_main.cfg, dir/b/_main.cfg and dir/other.cfg to be included.
--
-- If there's a file named _final.cfg but no _main.cfg, the file is guaranteed to be included and processed after all the other files in the directory.
-- If there's a file named _initial.cfg but no _main.cfg, the file is guaranteed to be included and processed before all the other files in the directory.
------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- sequence:
-- _main.wsl is processed first
-- _final.wsl is processed last if no _main.wsl

local load_cfg_file

check_file = (path, name, env) ->
    file_path = path .. "/" .. name
    if fs.getInfo(file_path)
        LOG_FS.debug"#{name} file found at #{path}"
        ret_val = load_cfg_file(file_path, env)
        return ret_val or true
    else
        return false


file_extensions = {
    "lua"
    "moon"
    "wsl"
}


scan_dir = (path, name, env) ->
    for ext in *file_extensions
        if ret = check_file(path, name .. '.' .. ext, env)
            return ret
    return false


----
--
-- @param path string which is expected to be the absolute path
include_dir = (path, env) ->
    LOG_FS.debug"Including #{path} directory"

    if ret = scan_dir(path, "_main", env)
        return ret

    ret = scan_dir(path, "_initial")

    for item in *fs.getDirectoryItems(path)

        continue if item\sub(1,1) == "."

        LOG_FS.debug"Processing #{item}"
        item_path = path .. '/' .. item

        item_info = fs.getInfo(item_path)
        switch item_info.type
            when "file"
                if item_path\sub(#item_path - 3) == ".wsl"
                    ret = load_cfg_file(item_path, env)
            when "directory"
                ret = include_dir(path .. item, env)

    ret = scan_dir(path, "_final") or ret

    return ret


local include_
toplevel_directory = get.data("")
include = (env) ->
    assert(env, "no environment provided")
    return include_(toplevel_directory, '', env)


----
--
-- @string path_str filepath to load
-- @returns
include_ = (script_base, path, env) ->

    local absolute_path
    if path\sub(1, 2) == "./"
        absolute_path = script_base .. '/' ..  path\sub(3)
        LOG_FS.debug("including relative path #{script_base}" ..
            " -/- #{path} >> #{absolute_path}")
    else
        absolute_path = toplevel_directory .. '/' .. path
        LOG_FS.debug("including absolute path #{toplevel_directory}" ..
            " -/- #{path} >> #{absolute_path}")

    if info = fs.getInfo(absolute_path)
        switch info.type
            when "symlink"
                LOG_FS.info"#{absolute_path} is a symlink"
                return include_dir(absolute_path, env)
            when "directory"
                return include_dir(absolute_path, env)
            when "file"
                return load_cfg_file(absolute_path, env)

    LOG_FS.trace"File not found at #{absolute_path}"
    return nil


----
-- Load a single file within the given environment.
-- @string file the filepath to load
-- @tab env environment to execute in
load_cfg_file = (file_path, env) ->
    panic_mode = true --- @todo read from a config?
    assert(env, "No env")
    assert(file_path, "No file")
    assert(fs.getInfo(file_path), "#{file_path}: File Not Found")
    text = fs.read(file_path)

    file_fun, err = moonscript.loadstring(text, env)
    unless file_fun
        --- err is most likely a syntax error
        LOG_FS.error("Error parsing file: '#{file_path}' >> '#{err}'")
        if panic_mode
            love.event.quit!
        return

    env.INCLUDE = (path) ->
        include_(file_path, path ,env)
    setfenv(file_fun, env)
    LOG_FS.debug"executing #{file_path}"
    try
        do: ->
            file_fun!
        catch: (err_msg) ->
            --- @todo better error output. Error is a runtime error
            error("Error executing file: " ..
                file_path .. ": " .. err_msg)
            if panic_mode
                LOG_FS.fatal("Panic Mode Exit")
                love.event.quit("exit")

    file_fun!

return include
