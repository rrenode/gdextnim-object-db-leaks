## Testing calling a nim static function of a non-resource
extends Node3D

enum TESTS { ERR_NO_ADD, WITH_ADD, ERR_NO_ADD_3, ERR_NO_ADD_WITH_NULL, NO_ADD_WITH_FREE}
@export var testToRun: TESTS = TESTS.ERR_NO_ADD

func _ready() -> void:
	match testToRun:
		TESTS.ERR_NO_ADD:
			a()
		TESTS.WITH_ADD:
			b()
		TESTS.ERR_NO_ADD_3:
			c()
		TESTS.ERR_NO_ADD_WITH_NULL:
			d()
		TESTS.NO_ADD_WITH_FREE:
			e()

func a() -> void:
	##==========================================================================
	## RendererMethod:Forward+ ->
	## 		ERROR: 1 RID allocations of type 'N17RendererSceneCull8InstanceE' were leaked at exit.
	##==========================================================================
	## RendererMethod:Compatability -> 
	## 		1 RID allocations of type 'N17RendererSceneCull8InstanceE' were leaked at exit.
	## 		ERROR: Cannot get path of node as it is not in a scene tree.
	## 			at: (scene/main/node.cpp:2419)
	## 		Leaked instance: MeshInstance3D:... - Node path:
	##==========================================================================
	noAdd()

func b() -> void:
	# Everything all good
	withAdd()

func c() -> void:
	##==========================================================================
	## RendererMethod:Forward+ ->
	## 		ERROR: 3 RID allocations of type 'N17RendererSceneCull8InstanceE' were leaked at exit.
	##==========================================================================
	## RendererMethod:Compatability -> 
	## 		1 RID allocations of type 'N17RendererSceneCull8InstanceE' were leaked at exit.
	## 		ERROR: Cannot get path of node as it is not in a scene tree.
	## 			at: (scene/main/node.cpp:2419)
	## 		Leaked instance: MeshInstance3D:... - Node path:
	## 		ERROR: Cannot get path of node as it is not in a scene tree.
	## 			at: (scene/main/node.cpp:2419)
	## 		Leaked instance: MeshInstance3D:... - Node path:
	## 		ERROR: Cannot get path of node as it is not in a scene tree.
	## 			at: (scene/main/node.cpp:2419)
	## 		Leaked instance: MeshInstance3D:... - Node path:
	##==========================================================================
	noAdd()
	noAdd()
	noAdd()

func d() -> void:
	##==========================================================================
	## RendererMethod:Forward+ ->
	## 		ERROR: 3 RID allocations of type 'N17RendererSceneCull8InstanceE' were leaked at exit.
	##==========================================================================
	## RendererMethod:Compatability -> 
	## 		1 RID allocations of type 'N17RendererSceneCull8InstanceE' were leaked at exit.
	## 		ERROR: Cannot get path of node as it is not in a scene tree.
	## 			at: (scene/main/node.cpp:2419)
	## 		Leaked instance: MeshInstance3D:... - Node path:
	##==========================================================================
	noAddWithNull()

func e() -> void:
	# Everything all good
	noAddWithFree()

func noAdd() -> void:
	var line = Draw3D.tline(Vector3(0,0,0), Vector3(0, 4, 0))
	line.name = "MYLINE"

func withAdd() -> void:
	var line = Draw3D.tline(Vector3(0,0,0), Vector3(0, 4, 0))
	line.name = "MYLINE"
	add_child(line)

func noAddWithNull() -> void:
	var line = Draw3D.tline(Vector3(0,0,0), Vector3(0, 4, 0))
	line.name = "MYLINE"
	line = null

func noAddWithFree() -> void:
	var line = Draw3D.tline(Vector3(0,0,0), Vector3(0, 4, 0))
	line.name = "MYLINE"
	line.free()
