extends Node

func _ready():
	#fromNim()
	#fromGd()
	fromNimTex()

func fromGd():
	var tex = load("res://icon.svg")
	var s = Sprite2D.new()
	s.texture = tex
	add_child(s)

func fromNim():
	var c = $ReturnResStates
	var tex = load("res://icon.svg")
	var s = c.createSprite()
	s.texture = tex
	add_child(s)

func fromNimTex():
	var c = $ReturnResStates
	var tex = load("res://icon.svg")
	var s = c.createWithTexture(tex)
	add_child(s)
