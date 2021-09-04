extends Node2D


onready var _catapult: Catapult = $Catapult
onready var _leafs: Node2D = $Leafs
onready var _tutorials: Node2D = $Tutorials


func _on_Button_pressed():
	_catapult.reset()
	for leaf in _leafs.get_children():
		leaf.reset()
