extends Node3D

class_name EnemySpawner

@export var enemy_scenes : Array[PackedScene]
@export var spawn_interval : Array[Vector2]
@export var spawn_distance : Array[Vector2]
@export var min_spawn_distance : int = 20
@export var max_spawn_distance : int = 50

@onready var spawn_timers = [$SpawnTimerSKMinion,$SpawnTimerSKRogue]

var player : Player
var rng = RandomNumberGenerator.new()


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	for i in spawn_timers.size() :
		spawn_timers.get(i).start(randf_range(spawn_interval.get(i).x,spawn_interval.get(i).y))
		spawn_timers.get(i).timeout_indice.connect(spawn_enemy)

func spawn_enemy(indice_enemy : int) -> void :
	if enemy_scenes.is_empty() || spawn_interval.is_empty() || spawn_distance.is_empty():
		return
	
	
	var distance : int = rng.randi_range(spawn_distance.get(indice_enemy).x, spawn_distance.get(indice_enemy).y)
	var angle = rng.randf_range(0,2 * PI)
	
	var x = player.global_position.x + distance * cos(angle)
	var z = player.global_position.z + distance * sin(angle)

	var enemy = enemy_scenes.get(indice_enemy).instantiate()
	
	get_parent().add_child(enemy)
	enemy.position = Vector3(x,0.0,z)
