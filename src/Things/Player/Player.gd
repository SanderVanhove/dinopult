extends RigidBody2D
class_name Player


onready var ground_col_timer: Timer = $GroundColTimer
onready var visuals: Node2D = $Visuals
onready var animation_player: AnimationPlayer = $Visuals/AnimationPlayer
onready var turn_sound: RandomStreamPlayer = $TurnSound
onready var whee_sound: RandomStreamPlayer = $WheeSound
onready var fall_sound: RandomStreamPlayer = $FallSound
onready var oof_timer: Timer = $OofTimer


var is_launched: bool = false
var can_turn: bool = true
var did_oof: bool = false
var movement_before_sleep: Vector2


func _ready():
	set_bounce(.25)


func _process(delta):
	visuals.scale.x = -1 if linear_velocity.x < 0 else 1
	
	if get_colliding_bodies().size() and oof_timer.is_stopped() and not did_oof:
		fall_sound.play()
		oof_timer.start()
		did_oof = true
	elif not get_colliding_bodies().size():
		did_oof = false


func launche(force: Vector2):
	apply_central_impulse(force)
	ground_col_timer.start()
	
	is_launched = true
	
	whee_sound.play()


func _on_GroundColTimer_timeout():
	set_collision_mask_bit(1, true)


func set_on_catapult():
	turn_sound.play()


func sleep(is_sleeping):
	sleeping = is_sleeping
	can_turn = not is_sleeping
	
	if is_sleeping:
		movement_before_sleep = linear_velocity
	else:
		linear_velocity = movement_before_sleep


func _input(event):
	if not event as InputEventMouseButton or event.pressed:
		return
	if not is_launched or not can_turn:
		return
		
	turn_sound.play()
		
	linear_velocity = linear_velocity.reflect(Vector2(0, 1))
	linear_velocity *= .9
	
	animation_player.play("swing")
	yield(animation_player, "animation_finished")
	animation_player.play("idle")
