# Package

version       = "1.0.0"
author        = "Rainbow Asteroids"
description   = "Hex clock made in SDL and Nim"
license       = "GPL-3.0-only"
srcDir        = "src"
bin           = @["hexclock"]


# Dependencies

requires "nim >= 1.4.8"
requires "sdl2"

switch "--gc", "arc"
