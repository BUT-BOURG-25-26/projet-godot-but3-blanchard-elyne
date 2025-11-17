extends Node3D

class_name EnemySpawner

@export var enemy_scenes : Array[PackedScene]
@export var spawn_interval : Array[Vector2]
@export var min_spawn_distance : int = 20
@export var max_spawn_distance : int = 50

@onready var spawn_timer =$SpawnTimer

var player : Player
var rng = RandomNumberGenerator.new()


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	spawn_timer.start(randf_range(spawn_interval.get(0).x,spawn_interval.get(0).y))
	spawn_timer.timeout.connect(spawn_enemy)

func spawn_enemy() -> void :
	if enemy_scenes.is_empty() || spawn_interval.is_empty():
		return
	
	var distance : int = rng.randi_range(min_spawn_distance, max_spawn_distance)
	
	var x = 1 + rng.randf_range(-1, 1)
	var z = 1 + rng.randf_range(-1, 1)
	
	var enemy = enemy_scenes.get(0).instantiate()
	
	get_parent().add_child(enemy)
	enemy.position = player.global_position + (distance * Vector3(x,0.0,z).normalized())
