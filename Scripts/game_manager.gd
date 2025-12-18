extends Node

var current_score: int =0
var is_game_running = true
var difficulty_increase_interval = 10

@export var spawn_interval : Array[Vector2] = [Vector2(1,2),Vector2(2,3)]
@onready var main_scene : PackedScene = preload("res://Scene/main_scene.tscn")
@onready var game_over_scene : PackedScene = preload("res://Scene/UI/game_over_menu.tscn")
@onready var difficulty_timer : Timer


func start_difficulty_timer()-> void :
	difficulty_timer = get_tree().get_first_node_in_group("difficulty_timer")
	difficulty_timer.start(difficulty_increase_interval)

func increase_score(score)-> void  :
	current_score += score

func game_over()-> void :
	is_game_running = false
	get_tree().change_scene_to_packed(game_over_scene)
	get_tree().reload_current_scene()


func restart()-> void :
	get_tree().change_scene_to_packed(main_scene)
	get_tree().reload_current_scene()
	is_game_running = true
	current_score = 0


func quit() -> void :
	get_tree().quit()

func increase_difficulty() -> void:
	var spawn_interval_temp = []
	for i in spawn_interval.size():
		spawn_interval_temp.append(spawn_interval.get(i)*0.5)
	return
