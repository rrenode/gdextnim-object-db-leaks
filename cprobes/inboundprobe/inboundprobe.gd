extends Node3D

@onready var probe = $InboundSetterProbe
var tex: Texture2D

func _ready() -> void:
	tex = load("res://icon.svg")

func _process(_delta: float) -> void:
	probe.texture = tex
