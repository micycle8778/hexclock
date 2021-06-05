import std/times
import sdl2, sdl2/ttf
import private/hex

doAssert sdl2.init(INIT_EVERYTHING) == SdlSuccess
doAssert ttfInit() == SdlSuccess

const font_data = slurp"../Comfortaa-Light.ttf".cstring
let font_RWops = font_data.rwFromConstMem(font_data.len)
let font = font_RWops.openFontRW(0, 64)

var window: WindowPtr
var renderer: RendererPtr

window = createWindow("Hex Clock", 100, 100, 640, 480, SDL_WINDOW_SHOWN or SDL_WINDOW_RESIZABLE)
# window.setMinimumSize(200, 200)

renderer = createRenderer(window, -1, Renderer_Accelerated or Renderer_PresentVsync or Renderer_TargetTexture)

var evt = sdl2.defaultEvent
var running = true

while running:
  # Event handling
  while pollEvent(evt):
    # Stop the program when the OS tells us to close
    if evt.kind == QuitEvent:
      running = false
      break

  # Get the time
  let s = now().format("HHmmss")

  # Parse the time as a color string
  let n = s.decodeHexString
  let r = (n shr 16) mod 255
  let g = (n shr 8) mod 255
  let b = n mod 255

  # Fill the window with the interpreted color
  renderer.setDrawColor(color(r, g, b, 255))
  renderer.clear()

  # Get the size of our window
  var window_w, window_h: cint
  doAssert renderer.getRendererOutputSize(addr window_w, addr window_h) == 0
  
  # Render some text
  let surface = renderTextBlended(font, '#' & s, color(255, 255, 255, 255))
  let texture = createTextureFromSurface(renderer, surface)
  
  # Get the size of the rendered text
  var texture_w, texture_h: cint
  texture.queryTexture(nil, nil, addr texture_w, addr texture_h)

  # Determine the center of the window
  let middle_x = (window_w - texture_w) div 2
  let middle_y = (window_h - texture_h) div 2

  # Actually blit the font at the center of the window
  var dstrect: Rect = (middle_x, middle_y, texture_w, texture_h)
  renderer.copy(texture, nil, addr dstrect)

  # Clean up
  destroy surface
  destroy texture

  # Update the window
  renderer.present()

destroy renderer
destroy window
