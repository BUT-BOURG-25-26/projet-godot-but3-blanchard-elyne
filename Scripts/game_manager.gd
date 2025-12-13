extends Node

var current_score: int =0
var is_game_running = true


func increase_score(score)-> void  :
	current_score += score
	print("score : ",current_score)

func game_over()-> void :
	#var uimanager : UIManager = get_tree().get_first_node_in_group("ui_manager")
	#uimanager.display_end_buttons(true)
	is_game_running = false
	restart()

func restart()-> void :
	get_tree().reload_current_scene()
	is_game_running = true
	current_score = 0


func quit() -> void :
	get_tree().quit()
