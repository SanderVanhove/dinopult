extends RigidBody2D
class_name Player


onready var ground_col_timer: Timer = $GroundColTimer
onready var visuals: Node2D = $Visuals
onready var animation_player: AnimationPlayer = $Visuals/AnimationPlayer


var is_launched: bool = false


func _ready():
	set_bounce(.25)


func _process(delta):
	visuals.scale.x = -1 if linear_velocity.x < 0 else 1


func launche(force: Vector2):
	apply_central_impulse(force)
	ground_col_timer.start()
	
	is_launched = true


func _on_GroundColTimer_timeout():
	set_collision_mask_bit(1, true)


func _input(event):
	if not event as InputEventMouseButton or event.pressed:
		return
	if not is_launched:
		return
		
	linear_velocity = linear_velocity.reflect(Vector2(0, 1))
	linear_velocity *= .9
	
	animation_player.play("swing")
	yield(animation_player, "animation_finished")
	animation_player.play("idle")
