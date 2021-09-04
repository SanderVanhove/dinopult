extends Node2D


onready var _catapult: Catapult = $Catapult


func _on_Button_pressed():
	_catapult.reset()
