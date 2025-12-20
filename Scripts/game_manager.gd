extends Node

var current_score: int =0
var is_game_running = true
@export var difficulty_increase_interval = 10
@export var spawn_interval_orig : Array[Vector2] = [Vector2(1,2),Vector2(2,3)]
@export var spawn_number_orig : Array[float] = [1,-1,-3,-6]

var spawn_interval : Array[Vector2] = spawn_interval_orig
var spawn_number : Array[float] = spawn_number_orig
@onready var main_scene : PackedScene = preload("res://Scene/main_scene.tscn")
@onready var game_over_scene : PackedScene = preload("res://Scene/UI/game_over_menu.tscn")
@onready var difficulty_timer : Timer


func start_difficulty_timer()-> void :
	difficulty_timer = get_tree().get_first_node_in_group("difficulty_timer")
	difficulty_timer.timeout.connect(increase_difficulty)
	difficulty_timer.start(difficulty_increase_interval)

func increase_score(score)-> void  :
	current_score += score

func game_over()-> void :
	is_game_running = false
	spawn_interval = spawn_interval_orig
	spawn_number = spawn_number_orig
	get_tree().change_scene_to_packed(game_over_scene)
	get_tree().reload_current_scene()


func restart()-> void :
	is_game_running = true
	current_score = 0
	get_tree().change_scene_to_packed(main_scene)
	get_tree().reload_current_scene()


func quit() -> void :
	get_tree().quit()

func increase_difficulty() -> void:
	var spawn_interval_temp : Array[Vector2] = []
	var spawn_number_temp : Array[float] = []
	for i in spawn_interval.size():
		spawn_interval_temp.append(spawn_interval.get(i)-spawn_interval.get(i)*0.01)
	for i in spawn_number.size():
		spawn_number_temp.append(spawn_number.get(i)+0.5)
	spawn_interval = spawn_interval_temp
	spawn_number = spawn_number_temp
	return
