import gdext
import gdext/classes/[gdNode, gdTexture2D, gdResourceLoader]

type MethodOnlyProbe* {.gdsync.} = ptr object of Node
  texture*: gdref Texture2D

proc getTextureMethod(self: MethodOnlyProbe): gdref Texture2D {.gdsync.} =
  self.texture

method ready(self: MethodOnlyProbe) {.gdsync.} =
  let res = ResourceLoader.load("res://icon.svg")
  self.texture = (res as gdref Texture2D)