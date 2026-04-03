extends Node

var renderMethod = RenderingServer.get_current_rendering_method()
var renderDriver = RenderingServer.get_current_rendering_driver_name()

func _ready() -> void:
	match renderMethod:
		"gl_compatibility":
			print("Compatability renderer in use... expect gdext-nim leaks")
		_:
			print("")
	print(renderMethod)
	print(renderDriver)

func getOrphans() -> Array[Node]:
	var result = []
	for id in Node.get_orphan_node_ids():
		result.append(instance_from_id(id))
	return result

func cleanAllOrphans() -> void:
	for o in getOrphans():
		o.free()

func print_orphans() -> void:
	for o in getOrphans():
		print("Found orphan: ", o.name, " (Type: ", o.get_class(), ")")
