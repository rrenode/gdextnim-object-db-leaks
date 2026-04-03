extends Node3D

@onready var probe = $GetterOnlyProbe

func _process(_delta: float) -> void:
	var t = probe.texture
