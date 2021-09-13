extends Node2D
class_name Catapult
signal fired

const MAX_DIST: float = 100.0

onready var _player: Player = $Player
onready var _audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
onready var _fire_audio: AudioStreamPlayer2D = $AudioStreamPlayer2D2

onready var _elastic_front: Line2D = $ElasticFront
onready var _elastic_back: Line2D = $ElasticBack
onready var _elastic_left_end: Node2D = $ElasticLeftEnd
onready var _elastic_right_end: Node2D = $ElasticRightEnd
onready var _elastic_return_tween: Tween = $ElasticReturn


var is_pulling: bool = false
var player_in: bool = true
var is_allowed_to_fire: bool = true
var click_position: Vector2 = Vector2.ZERO


func _ready():
	reset()


func reset():
	update_elastic(Vector2.ZERO)
	is_pulling = false
	player_in = true


func sleep(is_sleeping: bool):
	is_allowed_to_fire = not is_sleeping
	_player.sleep(is_sleeping)


func _process(delta):
	if not is_pulling and not player_in:
		return

	make_player_stick()
	_player.transform.origin = get_pull_dist()

	update_elastic(_player.position)


func _input(event):
	if not event as InputEventMouseButton:
		return

	if not is_allowed_to_fire:
		return

	if player_in and event.pressed:
		is_pulling = true
		click_position = get_viewport().get_mouse_position()
		_audio.play()

	if is_pulling and not event.pressed:
		if get_pull_dist().length() < 10:
			make_player_stick()
			return

		_player.launche(-get_pull_dist() * 15)

		_fire_audio.play()
		_audio.stop()

		is_pulling = false
		player_in = false

		_elastic_return_tween.interpolate_method(self, "update_elastic", _player.position, Vector2.ZERO, .8, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
		_elastic_return_tween.start()

		emit_signal("fired")


func update_elastic(mid: Vector2):
	_elastic_front.points = PoolVector2Array([_elastic_left_end.position, mid])
	_elastic_back.points = PoolVector2Array([_elastic_right_end.position, mid])


func get_pull_dist():
	if not is_pulling:
		return Vector2.ZERO

	var mouse_dist = get_viewport().get_mouse_position() - click_position
	return mouse_dist.clamped(MAX_DIST)


func make_player_stick():
	_player.angular_velocity = 0
	_player.rotation = get_pull_dist().angle() + PI if is_pulling else 0
	_player.linear_velocity = Vector2.ZERO
	_player.global_transform.origin = position
	_player.sleeping = true
	player_in = true


func _on_ClickArea_body_entered(body):
	if player_in:
		return

	_player.set_on_catapult()
	_elastic_return_tween.interpolate_property(_player, "global_transform:origin", _player.global_transform.origin, position, .2, Tween.TRANS_BACK, Tween.EASE_OUT)
	_elastic_return_tween.start()
	yield(_elastic_return_tween, "tween_all_completed")

	make_player_stick()
