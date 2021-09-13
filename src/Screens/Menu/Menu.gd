extends Node2D


func _ready():
	pass


func _on_Label_gui_input(event):
	if not event as InputEventMouseButton or event.pressed:
		return

	OS.shell_open("https://twitter.com/SanderVhove")


func _on_Button_pressed():
	get_tree().change_scene("res://Screens/StorySlide/StorySlide.tscn")


func _on_Label2_gui_input(event):
	if not event as InputEventMouseButton or event.pressed:
		return

	OS.shell_open("https://www.patreon.com/sandervanhove")
