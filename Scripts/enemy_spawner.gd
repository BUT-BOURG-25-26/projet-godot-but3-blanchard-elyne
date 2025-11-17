extends Node3D

class_name EnemySpawner

@export var enemy_scenes : Array[PackedScene]
@export var spawn_interval : Array[Vector2]
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
	if enemy_scenes.is_empty() || spawn_interval.is_empty():
		return
	
	var distance : int = rng.randi_range(min_spawn_distance, max_spawn_distance)
	
	var x = 1 + rng.randf_range(-1, 1)
	var z = 1 + rng.randf_range(-1, 1)
	
	var enemy = enemy_scenes.get(indice_enemy).instantiate()
	
	get_parent().add_child(enemy)
	enemy.position = player.global_position + (distance * Vector3(x,0.0,z).normalized())
