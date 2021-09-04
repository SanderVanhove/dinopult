extends Control


func _ready():
	pass


func _on_Control_gui_input(event):
	if not event as InputEventMouseButton or event.pressed:
		return
	
	get_tree().set_input_as_handled()
	queue_free()
