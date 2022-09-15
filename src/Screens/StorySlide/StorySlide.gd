extends Control


export(String, FILE) var nextScene


onready var _tween: Tween = $Tween
onready var _timer: Timer = $Timer


func _ready() -> void:
	modulate.a = 0
	_tween.interpolate_property(self, "modulate:a", 0, 1, .3, Tween.TRANS_SINE, Tween.EASE_IN)
	_tween.start()


func _on_StorySlide_gui_input(event: InputEvent) -> void:
	if not _timer.is_stopped():
		return
	if not event.is_action_pressed("click"):
		return

	_tween.interpolate_property(self, "modulate:a", 1, 0, .3, Tween.TRANS_SINE, Tween.EASE_IN)
	_tween.start()

	yield(_tween, "tween_all_completed")

	get_tree().set_input_as_handled()
	get_tree().change_scene(nextScene)
