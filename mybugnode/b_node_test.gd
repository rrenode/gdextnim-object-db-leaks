extends Node3D

func _process(_delta: float):
	var bn = get_node("MyBuggedNode")
	if not bn: return
	bn.clsProp.get_class()
