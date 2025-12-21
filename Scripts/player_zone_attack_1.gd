extends Area3D
class_name PlayerAttackZone

var player : Player
var move : Vector3

@export var damage = 1

@onready var animation_player : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	global_position = player.global_position
	animation_player.play("grow")

func _on_body_entered(body: Node3D) -> void:
	if body is Enemy :
		print("attackZone")
		(body as Enemy).take_damage(damage)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "grow" :
		queue_free()
