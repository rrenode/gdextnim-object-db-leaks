extends Node

func _ready():
	var c = $ReturnResStates
	var tex = load("res://icon.svg")
	print(c.getSprite())
	var s = c.createSprite()
	s.texture = tex
	add_child(s)
