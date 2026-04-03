import gdext
import gdext/classes/[gdNode, gdTexture2D]

type InboundSetterProbe* {.gdsync.} = ptr object of Node
  texture*: gdref Texture2D

proc setTexture(self: InboundSetterProbe; value: gdref Texture2D) {.gdsync.} =
  self.texture = value

proc getTexture(self: InboundSetterProbe): gdref Texture2D {.gdsync.} =
  self.texture

gdexport "texture",
  getter = getTexture,
  setter = setTexture