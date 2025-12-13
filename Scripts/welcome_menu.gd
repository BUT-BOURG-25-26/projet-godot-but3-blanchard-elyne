extends CanvasLayer

@onready var main_scene : PackedScene = preload("res://Scene/main_scene.tscn")

func _on_quit_button_pressed() -> void:
	GameManager.quit()


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(main_scene)
