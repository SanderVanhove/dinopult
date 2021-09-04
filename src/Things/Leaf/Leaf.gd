extends Node2D
tool

signal collected


export(Texture) var leafe_sprite: Texture


onready var particles1: CPUParticles2D = $CPUParticles2D
onready var particles2: CPUParticles2D = $CPUParticles2D2
onready var sprite: Sprite = $Sprite
onready var area: Area2D = $Area2D


func _ready():
	if leafe_sprite:
		sprite.texture = leafe_sprite


func reset():
	sprite.visible = true
	area.monitoring = true
	area.monitorable = true


func _on_Area2D_body_entered(body):
	if not sprite.visible:
		return
		
	emit_signal("collected")
	
	sprite.visible = false
	area.monitoring = false
	area.monitorable = false
	
	particles1.emitting = true
	particles2.emitting = true
