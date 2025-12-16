extends CanvasLayer

@onready var score_label : Label = $ScoreLabel

func _ready() -> void:
	score_label.text += str(GameManager.current_score)

func _on_restart_button_pressed() -> void:
	GameManager.restart()


func _on_quit_button_pressed() -> void:
	GameManager.quit()
