import gdext
import gdext/classes/[gdNode, gdTexture2D, gdResourceLoader]

type GdRefReturnProbe* {.gdsync.} = ptr object of Node
  texture*: gdref Texture2D

proc setTexture(self: GdRefReturnProbe; value: gdref Texture2D) {.gdsync.} =
  discard self.texture[].unreference()
  self.texture = value

proc getTexture(self: GdRefReturnProbe): gdref Texture2D {.gdsync.} =
  self.texture

gdexport "texture",
  getter = getTexture,
  setter = setTexture

proc getTextureMethod(self: GdRefReturnProbe): gdref Texture2D {.gdsync.} =
  self.texture

method ready(self: GdRefReturnProbe) {.gdsync.} =
  let res = ResourceLoader.load("res://icon.svg")
  self.texture = (res as gdref Texture2D)
