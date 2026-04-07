import gdext
import gdext/classes/[gdNode, gdTexture2D, gdSprite2D]

type ReturnResStates* {.gdsync.} = ptr object of Node
  sprite*: Sprite2D

proc getSprite(self: ReturnResStates): Sprite2D {.gdsync.} =
  self.sprite

proc setSprite(self: ReturnResStates; value: Sprite2D) {.gdsync.} =
  self.sprite.queueFree()
  self.sprite = value

gdexport "sprite",
  getter = getSprite,
  setter = setSprite


proc createSprite(self: ReturnResStates): Sprite2D {.gdsync.} =
  var s: Sprite2D = instantiate Sprite2D
  return s

proc createWithTexture(self: ReturnResStates; tex: gdref Texture2D): Sprite2D {.gdsync.} =
  var s: Sprite2D = instantiate Sprite2D
  s.texture = tex
  return s
