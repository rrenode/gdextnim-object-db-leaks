extends Node3D

@onready var probe := $GdRefReturnProbe

func _process(_delta: float) -> void:
	if probe == null:
		return

	# Property getter path
	var tex_a = probe.texture
	if tex_a:
		tex_a.get_class()

	# Method return path
	var tex_b = probe.getTextureMethod()
	if tex_b:
		tex_b.get_class()
