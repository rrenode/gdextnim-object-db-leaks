import gdext
import gdext/classes/[
  gdNode, gdMeshInstance3D, gdImmediateMesh, gdStandardMaterial3D, 
  gdMesh, gdMaterial
]

type Draw3D* {.gdsync.} = ptr object of Node

proc makeLineMesh*(T: typedesc[Draw3D]; pos1, pos2: Vector3): gdref ImmediateMesh {.gdsync.} =
  let imMesh = instantiate ImmediateMesh
  imMesh[].surfaceBegin(primitiveLines)
  imMesh[].surfaceAddVertex(pos1)
  imMesh[].surfaceAddVertex(pos2)
  imMesh[].surfaceEnd()
  return imMesh

proc tline*(T: typedesc[Draw3D]; pos1, pos2: Vector3; color: Color = Color(r:1,g:1,b:1)): MeshInstance3D {.gdsync.} =
  var meshInstance = instantiate MeshInstance3D
  return meshInstance

proc line*(T: typedesc[Draw3D]; pos1, pos2: Vector3; color: Color = Color(r:1,g:1,b:1)): MeshInstance3D {.gdsync.} =
  var meshInstance = instantiate MeshInstance3D
  var imMesh: GdRef[ImmediateMesh] = instantiate ImmediateMesh
  imMesh[].surfaceBegin(primitiveLines)
  imMesh[].surfaceAddVertex(pos1)
  imMesh[].surfaceAddVertex(pos2)
  imMesh[].surfaceEnd()
  var imMeshRef = imMesh.castTo(gdref Mesh)
  meshInstance.setMesh(imMeshRef)
  # meshInstance.setMesh(imMesh as GdRef[Mesh]) #<-- Same issue with this
  return meshInstance