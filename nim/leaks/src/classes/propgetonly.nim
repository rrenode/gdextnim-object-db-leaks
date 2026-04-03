import gdext
import gdext/classes/[gdNode, gdTexture2D, gdResourceLoader]

type GetterOnlyProbe* {.gdsync.} = ptr object of Node
  texture*: gdref Texture2D

proc getTexture(self: GetterOnlyProbe): gdref Texture2D {.gdsync.} =
  self.texture

proc setTexture(self: GetterOnlyProbe; value: gdref Texture2D) {.gdsync.} =
  discard

gdexport "texture",
  getter = getTexture,
  setter = setTexture

method ready(self: GetterOnlyProbe) {.gdsync.} =
  let res = ResourceLoader.load("res://icon.svg")
  self.texture = (res as gdref Texture2D)