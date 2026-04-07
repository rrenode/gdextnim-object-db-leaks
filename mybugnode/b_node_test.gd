extends Node3D

var bn: Node

func _ready() -> void:
	bn = get_node("MyBuggedNode")
	if not bn: return
	var tex = ResourceLoader.load("res://icon.svg")
	bn.clsProp = tex

#func _process(_delta: float):
#	if not bn: return
#	bn.clsProp.get_class()
