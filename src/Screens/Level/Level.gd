extends Node2D


onready var _catapult: Catapult = $Catapult
onready var _leafs: Node2D = $Leafs

onready var _tutorial1: Tutorial = $Tutorials/Tutorial1
onready var _tutorial2: Tutorial = $Tutorials/Tutorial2
onready var _tutorial3: Tutorial = $Tutorials/Tutorial3
onready var _tutorial_timer: Timer = $Tutorials/TutorialTimer

onready var _end_timer: Timer = $EndOfLevelTimer

onready var _click_audio: AudioStreamPlayer = $ClickAudio

var collected_leafs = 0


func _ready():
	show_tutorial(_tutorial1)

	for leaf in _leafs.get_children():
		leaf.connect("collected", self, "check_win")


func check_win():
	collected_leafs += 1
	if collected_leafs < len(_leafs.get_children()):
		return

	_end_timer.start()
	yield(_end_timer, "timeout")

	get_tree().change_scene("res://Screens/StorySlide/StorySlide4.tscn")


func _on_Button_pressed():
	_catapult.reset()
	for leaf in _leafs.get_children():
		leaf.reset()

	collected_leafs = 0

	_click_audio.play()


func show_tutorial(tutorial: Tutorial):
	_catapult.sleep(true)
	yield(tutorial.show_up(), "completed")
	_catapult.sleep(false)


func _on_Catapult_fired():
	if not is_instance_valid(_tutorial2):
		return

	_tutorial_timer.start()
	yield(_tutorial_timer, "timeout")

	_catapult.sleep(true)
	yield(_tutorial2.show_up(), "completed")
	yield(_tutorial3.show_up(), "completed")
	_catapult.sleep(false)
