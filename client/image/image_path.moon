----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

import recolor_image from require"client.image.utils"

Color_Range = {
    id: 1
        -- rgb: {"FF0000", "FFFFFF", "000000", "FF0000"}
    -- rgb: {"FF0000", "FFFFFF", "000000", "FF0000"}
    rgb: {"D1620D", "FFFFFF", "000000", "FF0000"}

    -- name: _ "Red"
}


Color_Palette = {
-- magenta is currently the value used to recolor most images
    magenta: {"F49AC1", "3F0016", "55002A", "690039", "7B0045", "8C0051", "9E005D", "B10069", "C30074", "D6007F", "EC008C", "EE3D96", "EF5BA1", "F172AC", "F287B6", "F6ADCD", "F8C1D9", "FAD5E5", "FDE9F1"}

-- flag_green is used to recolor the flag images at data/core/images/flags/
    flag_green: {"00C800", "00FF00", "00FE00", "00FD00", "00FC00", "00FB00",
    "00FA00", "00F900", "00F800", "00F700", "00F600", "00F500", "00F400",
    "00F300", "00F200", "00F100", "00F000", "00EF00", "00EE00", "00ED00",
    "00EC00", "00EB00", "00EA00", 00E900, 00E800, 00E700, 00E600, 00E500,
    00E400, 00E300, 00E200, 00E100, 00E000, "00DF00", "00DE00",
    "00DD00", "00DC00", "00DB00", "00DA00", "00D900", "00D800", "00D700", "00D600", "00D500", "00D400", "00D300", "00D200", "00D100", "00D000", "00CF00", "00CE00", "00CD00", "00CC00", "00CB00", "00CA00", "00C900", "00C700", "00C600", "00C500", "00C400", "00C300", "00C200", "00C100", "00C000", "00BF00", "00BE00", "00BD00", "00BC00", "00BB00", "00BA00", "00B900", "00B800", "00B700", "00B600", "00B500", "00B400", "00B300", "00B200", "00B100", "00B000", "00AF00", "00AE00", "00AD00", "00AC00", "00AB00", "00AA00", "00A900", "00A800", "00A700", "00A600", "00A500", "00A400", "00A300", "00A200", "00A100", "00A000", "009F00", 009E00, "009D00", "009C00", "009B00", "009A00", 009900, 009800, 009700, 009600, 009500, 009400, 009300, 009200, 009100, 009000, "008F00", 008E00, "008D00", "008C00", "008B00", "008A00", 008900, 008800, 008700, 008600, 008500, 008400, 008300, 008200, 008100, 008000, "007F00", 007E00, "007D00", "007C00", "007B00", "007A00", 007900, 007800, 007700, 007600, 007500, 007400, 007300, 007200, 007100, 007000, "006F00", 006E00, "006D00", "006C00", "006B00", "006A00", 006900, 006800, 006700, 006600, 006500, 006400, 006300, 006200, 006100, 006000, "005F00", 005E00, "005D00", "005C00", "005B00", "005A00", 005900, 005800, 005700, 005600, 005500, 005400, 005300, 005200, 005100, 005000, "004F00", 004E00, "004D00", "004C00", "004B00", "004A00", 004900, 004800, 004700, 004600, 004500, 004400, 004300, 004200, 004100, 004000, "003F00", 003E00, "003D00", "003C00", "003B00", "003A00", 003900, 003800, 003700, 003600, 003500, 003400, 003300, 003200, 003100, 003000, "002F00", 002E00, "002D00", "002C00", "002B00", "002A00", 002900, 002800, 002700, 002600, 002500, 002400, 002300, 002200, 002100, 002000, "001F00", 001E00, "001D00", "001C00", "001B00", "001A00", 001900, 001800, 001700, 001600, 001500, 001400, 001300, 001200, 001100, 001000, "000F00", 000E00, "000D00", "000C00", "000B00", "000A00", 000900, 000800, 000700, 000600, 000500, 000400, 000300, 000200, 000100}

-- ellipse_red is used to recolor the unit ellipses at images/misc/ellipse-*
    ellipse_red: {"C80000", "FF0000", "FE0000", "FD0000", "FC0000", "FB0000", "FA0000", "F90000", "F80000", "F70000", "F60000", "F50000", "F40000", "F30000", "F20000", "F10000", "F00000", "EF0000", "EE0000", "ED0000", "EC0000", "EB0000", "EA0000", "E90000", "E80000", "E70000", "E60000", "E50000", "E40000", "E30000", "E20000", "E10000", "E00000", "DF0000", "DE0000", "DD0000", "DC0000", "DB0000", "DA0000", "D90000", "D80000", "D70000", "D60000", "D50000", "D40000", "D30000", "D20000", "D10000", "D00000", "CF0000", "CE0000", "CD0000", "CC0000", "CB0000", "CA0000", "C90000", "C70000", "C60000", "C50000", "C40000", "C30000", "C20000", "C10000", "C00000", "BF0000", "BE0000", "BD0000", "BC0000", "BB0000", "BA0000", "B90000", "B80000", "B70000", "B60000", "B50000", "B40000", "B30000", "B20000", "B10000", "B00000", "AF0000", "AE0000", "AD0000", "AC0000", "AB0000", "AA0000", "A90000", "A80000", "A70000", "A60000", "A50000", "A40000", "A30000", "A20000", "A10000", "A00000", "9F0000", 9E0000, "9D0000", "9C0000", "9B0000", "9A0000", 990000, 980000, 970000, 960000, 950000, 940000, 930000, 920000, 910000, 900000, "8F0000", 8E0000, "8D0000", "8C0000", "8B0000", "8A0000", 890000, 880000, 870000, 860000, 850000, 840000, 830000, 820000, 810000, 800000, "7F0000", 7E0000, "7D0000", "7C0000", "7B0000", "7A0000", 790000, 780000, 770000, 760000, 750000, 740000, 730000, 720000, 710000, 700000, "6F0000", 6E0000, "6D0000", "6C0000", "6B0000", "6A0000", 690000, 680000, 670000, 660000, 650000, 640000, 630000, 620000, 610000, 600000, "5F0000", 5E0000, "5D0000", "5C0000", "5B0000", "5A0000", 590000, 580000, 570000, 560000, 550000, 540000, 530000, 520000, 510000, 500000, "4F0000", 4E0000, "4D0000", "4C0000", "4B0000", "4A0000", 490000, 480000, 470000, 460000, 450000, 440000, 430000, 420000, 410000, 400000, "3F0000", 3E0000, "3D0000", "3C0000", "3B0000", "3A0000", 390000, 380000, 370000, 360000, 350000, 340000, 330000, 320000, 310000, 300000, "2F0000", 2E0000, "2D0000", "2C0000", "2B0000", "2A0000", 290000, 280000, 270000, 260000, 250000, 240000, 230000, 220000, 210000, 200000, "1F0000", 1E0000, "1D0000", "1C0000", "1B0000", "1A0000", 190000, 180000, 170000, 160000, 150000, 140000, 130000, 120000, 110000, 100000, "0F0000", 0E0000, "0D0000", "0C0000", "0B0000", "0A0000", 090000, 080000, 070000, 060000, 050000, 040000, 030000, 020000, 010000}
}


get_Color_Range = (cfg) ->
    res =
        id:   cfg.id
        name: cfg.name
        min:  cfg.rgb[3]
        mid:  cfg.rgb[1]
        max:  cfg.rgb[2]
        rep:  cfg.rgb[4]
    return res
    -- @Data.Color_Range[cfg.id] = res

log = (require'log')'Image Loader'
love = love
-- lg = love.graphics
-- get = require"filesystem"
stringx = require"pl.stringx"
stringx.import!

binary_path = {
    "images"
    "data/core/images"
    "data/campaigns/An_Orcish_Incursion" .. "/images"
}

get_binary = (path) ->
    for bin_path in *binary_path
        if love.filesystem.getInfo("assets/" .. bin_path .. "/" .. path)
            -- print  "assets/" .. bin_path .. "/" .. path
            return "assets/" .. bin_path .. "/" .. path
    log.warn"Image #{path} not found"
    return nil

-- import hex2rgb, rgb2hex from require"client.image.utils"

-- r,g,b = hex2rgb("4242F4")
-- assert(r == 66,  "r should be 66  but is #{r}")
-- assert(g == 66,  "g should be 66  but is #{g}")
-- assert(b == 244, "b should be 244 but is #{b}")

-- hex = rgb2hex(66,66,244, 15)
-- assert(hex == "4242F4", "hex should be 4242F4 but is #{hex}")

image_cache = {}
image_path = (path) ->

    sep = '~'

    fields = path\split(sep)

    raw_path = fields[1]
    unless raw_path
        raw_path = path

    unless image_cache[path]
        if get_binary(raw_path)

            ext = fields[2]
            switch ext
                when "RC"
                    image = love.image.newImageData(get_binary(raw_path))

                    range   = get_Color_Range(Color_Range)
                    palette = Color_Palette.magenta

                    recolor_range = require"client.image.color_range"
                    map_rgb = recolor_range(range, palette)

                    image_cache[path] = love.graphics.newImage(
                        recolor_image(image, map_rgb) )
                when "RIGHT()"
                    --- @todo this is only a stub
                    image_cache[path] = love.graphics.newImage(
                        get_binary raw_path)
                else
                    image_cache[path] = love.graphics.newImage(
                        get_binary path)

    return image_cache[path]

return image_path
