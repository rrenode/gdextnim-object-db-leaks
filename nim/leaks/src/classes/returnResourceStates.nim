import gdext
import gdext/classes/[gdNode, gdTexture2D, gdSprite2D]

type ReturnResStates* {.gdsync.} = ptr object of Node

proc createSprite(self: ReturnResStates): Sprite2D {.gdsync.} =
  var s: Sprite2D = instantiate Sprite2D
  return s

proc createWithTexture(self: ReturnResStates; tex: gdref Texture2D): Sprite2D {.gdsync.} =
  var s: Sprite2D = instantiate Sprite2D
  s.texture = tex
  return s
