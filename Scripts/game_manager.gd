extends Node

var current_score: int =0
var is_game_running = true

@onready var main_scene : PackedScene = preload("res://Scene/main_scene.tscn")
@onready var game_over_scene : PackedScene = preload("res://Scene/UI/game_over_menu.tscn")

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
