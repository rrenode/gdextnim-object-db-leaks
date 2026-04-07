import gdext
import gdext/classes/[
  gdArea3D, gdcollisionshape3d, gdsprite3d, gdShape3D, gdTexture2D,
  gdMeshInstance3D, gdEngine, gdResourceLoader, gdMaterial,
  gdBoxShape3D, gdBoxMesh
  ]

type IconProp = enum
  ipTexture, ipScale, ipFilter, ipAll

type InteractableBillboardMesh* {.gdsync.} = ptr object of Area3D
  iconTexture*: gdref Texture2D
  iconScale*: Vector3 = vector3(1, 1, 1)
  textureFilter*: BaseMaterial3D_TextureFilter = textureFilterNearest

proc syncIcon(self: InteractableBillboardMesh, prop: IconProp)

proc setIconTexture(self: InteractableBillboardMesh; v: gdref Texture2D) {.gdsync.} =
  self.iconTexture = v
  discard self.callDeferred("syncIcon", ipTexture)

proc setIconScale(self: InteractableBillboardMesh; v: Vector3) {.gdsync.} =
  self.iconScale = v
  discard self.callDeferred("syncIcon", ipScale)

proc setTextureFilter(self: InteractableBillboardMesh; v: BaseMaterial3D_TextureFilter) {.gdsync.} =
  self.textureFilter = v
  discard self.callDeferred("syncIcon", ipFilter)

gdexport "iconTexture",
  proc(self: InteractableBillboardMesh): gdref Texture2D = self.iconTexture,
  setIconTexture

gdexport "iconScale",
  proc(self: InteractableBillboardMesh): Vector3 = self.iconScale,
  setIconScale

gdexport "textureFilter",
  proc(self: InteractableBillboardMesh): BaseMaterial3D_TextureFilter = self.textureFilter,
  setTextureFilter

proc getOrCreateIconNode(self: InteractableBillboardMesh): Sprite3D {.gdsync.} =
  let existing = self.getNodeOrNull("GeneratedIcon")
  if existing != nil:
    return existing as Sprite3D

  let node: Sprite3D = instantiate Sprite3D
  node.name = "GeneratedIcon"
  node.billboard = billboardEnabled
  self.addChild(node)
  node.owner = self
  return node

proc syncIcon(self: InteractableBillboardMesh, prop: IconProp) {.gdsync.} =
  if not self.isInsideTree():
    return
  let icon = self.getOrCreateIconNode()

  case prop
  of ipTexture:
    icon.texture = self.iconTexture
  of ipFilter:
    icon.textureFilter = self.textureFilter
  of ipScale:
    icon.scale = self.iconScale
  of ipAll:
    icon.texture = self.iconTexture
    icon.scale = self.iconScale

proc cleanupIcon(self: InteractableBillboardMesh) {.gdsync.} =
  let icon = self.getNodeOrNull("GeneratedIcon")
  if icon != nil and not icon.isInsideTree():
    icon.queueFree()

method onDestroy(self: InteractableBillboardMesh) =
  self.cleanupIcon()

method exitTree(self: InteractableBillboardMesh) =
  self.cleanupIcon()

method ready(self: InteractableBillboardMesh) {.gdsync.} =
  self.syncIcon(ipAll)