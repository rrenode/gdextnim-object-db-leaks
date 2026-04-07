import gdext
import gdext/classes/[
  gdNode, gdTexture2D, gdResourceLoader, gdRenderingServer, gdInput, gdInputEvent
  ]

type MyBuggedNode* {.gdsync.} = ptr object of Node
  clsProp*: gdref Texture2D

proc setclsProp(self: MyBuggedNode; v: gdref Texture2D) {.gdsync.} =
  if not self.clsProp[].isNil:
    discard self.clsProp[].unreference()
  self.clsProp = v
  printRich "WOB: Setting icon texture"

proc getclsProp(self: MyBuggedNode): gdref Texture2D {.gdsync.} =
  return self.clsProp

gdexport "clsProp",
  getter = getclsProp,
  setter = setclsProp

method ready(self: MyBuggedNode) {.gdsync.} =
  #var resource: gdref Resource = ResourceLoader.load("res://icon.svg")
  #self.clsProp = resource as gdref Texture2D
  discard

method process(self: MyBuggedNode, delta: float64) {.gdsync.} =
  discard self.clsProp[].getClass()

method input(self: MyBuggedNode; event: gdref InputEvent) {.gdsync.} = 
  if event[].isActionPressed("dev_a"):
    printRich $self.clsProp[].getReferenceCount()

method onDestroy(self: MyBuggedNode) =
  if not self.clsProp[].isNil:
    printRich "WOB::::clsProp not nil"
    echo $self.clsProp[].getReferenceCount()
    
    discard self.clsProp[].unreference()
    