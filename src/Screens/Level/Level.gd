extends Node2D


onready var _catapult: Catapult = $Catapult
onready var _leafs: Node2D = $Leafs

onready var _tutorial1: Tutorial = $Tutorials/Tutorial1
onready var _tutorial2: Tutorial = $Tutorials/Tutorial2
onready var _tutorial3: Tutorial = $Tutorials/Tutorial3
onready var _tutorial_timer: Timer = $Tutorials/TutorialTimer


func _ready():
	show_tutorial(_tutorial1)


func _on_Button_pressed():
	_catapult.reset()
	for leaf in _leafs.get_children():
		leaf.reset()


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
