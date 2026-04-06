import gdext
import gdext/classes/[
  gdNode, gdTexture2D, gdResourceLoader
  ]

type MyBuggedNode* {.gdsync.} = ptr object of Node
  clsProp*: gdref Texture2D

proc setclsProp(self: MyBuggedNode; v: gdref Texture2D) {.gdsync.} =
  self.clsProp = v
  printRich "WOB: Setting icon texture"

gdexport "clsProp",
  getter= proc(self: MyBuggedNode): gdref Texture2D = self.clsProp,
  setter= setclsProp

method ready(self: MyBuggedNode) {.gdsync.} =
  var resource: gdref Resource = ResourceLoader.load("res://icon.svg")
  self.clsProp = resource as gdref Texture2D