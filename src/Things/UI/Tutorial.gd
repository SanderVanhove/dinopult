extends Control
tool
class_name Tutorial
signal clicked


export(String) var title: String
export(String, MULTILINE) var text: String


onready var _title: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Label
onready var _text: RichTextLabel = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/RichTextLabel
onready var _click_audio: AudioStreamPlayer = $ClickAudio


func _ready():
	_title.text = title
	_text.bbcode_text = text


func _on_Control_gui_input(event: InputEvent):
	if not event.is_action_pressed("click"):
		return

	get_tree().set_input_as_handled()

	_click_audio.play()
	yield(_click_audio, "finished")
	emit_signal("clicked")
	queue_free()


func show_up():
	show()

	yield(self, "clicked")
