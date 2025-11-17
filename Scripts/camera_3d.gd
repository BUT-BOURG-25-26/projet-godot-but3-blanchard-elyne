extends Camera3D

class_name Camera


@export var offset : Vector3

var player 

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	global_position = player.global_position + offset
