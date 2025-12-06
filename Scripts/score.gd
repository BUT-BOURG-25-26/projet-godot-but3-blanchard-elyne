extends Label

@export var nb_digit_score: int = 6

func _process(delta: float):
	var score_text = str(GameManager.current_score)
	text=""
	for i in nb_digit_score - score_text.length():
		text += "0"
	text+= score_text
