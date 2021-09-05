extends Control
tool
class_name Tutorial
signal clicked


export(String) var title: String
export(String, MULTILINE) var text: String


onready var _title: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Label
onready var _text: RichTextLabel = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/RichTextLabel


func _ready():
	_title.text = title
	_text.text = text


func _on_Control_gui_input(event):
	if not event as InputEventMouseButton or event.pressed:
		return
	
	get_tree().set_input_as_handled()
	emit_signal("clicked")
	queue_free()


func show_up():
	show()
	
	yield(self, "clicked")
