extends Node2D


onready var _click_audio: AudioStreamPlayer = $ClickAudio


func _ready():
	pass


func _on_Label_gui_input(event):
	if not event as InputEventMouseButton or event.pressed:
		return

	OS.shell_open("https://twitter.com/SanderVhove")


func _on_Button_pressed():
	_click_audio.play()
	yield(_click_audio, "finished")
	get_tree().change_scene("res://Screens/StorySlide/StorySlide.tscn")


func _on_Label2_gui_input(event):
	if not event as InputEventMouseButton or event.pressed:
		return

	OS.shell_open("https://www.patreon.com/sandervanhove")
