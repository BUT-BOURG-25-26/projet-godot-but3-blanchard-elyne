extends Area3D

var player : Player
var move : Vector3

@export var damage = 1
@export var bullet_range = 50

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	move.x = player.look_at_point.x - player.global_position.x
	move.z = player.look_at_point.z - player.global_position.z

func _physics_process(delta: float) -> void:
	##if !GameManager.is_game_running:
		##return
	
	var x = global_position.x-player.global_position.x
	var z = global_position.z-player.global_position.z
	
	if ((x * x + z * z) >= (bullet_range * bullet_range)):
		queue_free()
	else :
		global_position += move

func _on_body_entered(body: Node3D) -> void:
	if body is Enemy :
		(body as Enemy).take_damage(damage)
		queue_free()
