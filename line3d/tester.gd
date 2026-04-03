## Testing calling a nim static function of a non-resource
extends Node3D

func _ready() -> void:
	a()
	#b()
	c()
	d()
	#e()
	pass

func a() -> void:
	# 1 RID allocations of type 'N17RendererSceneCull8InstanceE' were leaked at exit.
	# ERROR: Cannot get path of node as it is not in a scene tree.
	# 	at: (scene/main/node.cpp:2419)
	# Leaked instance: MeshInstance3D:... - Node path:
	noAdd()

func b() -> void:
	# Everything all good
	withAdd()

func c() -> void:
	# 3 RID allocations of type 'N17RendererSceneCull8InstanceE' were leaked at exit.
	# ERROR: Cannot get path of node as it is not in a scene tree.
	# 	at: (scene/main/node.cpp:2419)
	# Leaked instance: MeshInstance3D:... - Node path:
	# ERROR: Cannot get path of node as it is not in a scene tree.
	# 	at: (scene/main/node.cpp:2419)
	# Leaked instance: MeshInstance3D:... - Node path:
	# ERROR: Cannot get path of node as it is not in a scene tree.
	# 	at: (scene/main/node.cpp:2419)
	# Leaked instance: MeshInstance3D:... - Node path:
	noAdd()
	noAdd()
	noAdd()

func d() -> void:
	# 3 RID allocations of type 'N17RendererSceneCull8InstanceE' were leaked at exit.
	# ERROR: Cannot get path of node as it is not in a scene tree.
	# 	at: (scene/main/node.cpp:2419)
	# Leaked instance: MeshInstance3D:... - Node path:
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
