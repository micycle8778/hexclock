# hexclock
Hex clock made in SDL and Nim.

It interprets the current time as a color hex code and makes the window that
color (so if it was 7:42:15 PM, the color would be #194215).

![screenshot](screenshot.png)

## Installing
1. Get [Nim](https://nim-lang.org) via 
[choosenim](https://github.com/dom96/choosenim).

2. Install the dev version of SDL and SDL\_TTF however you'd do that for your 
platform. (package manager if on linux, brew if on macos, SDL webpage if on 
windows)

3. Run `nimble install https://github.com/RainbowAsteroids/hexclock`.
