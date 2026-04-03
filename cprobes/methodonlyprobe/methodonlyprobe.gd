extends Node3D

@onready var probe = $MethodOnlyProbe

func _process(_delta: float) -> void:
	var t = probe.getTextureMethod()
