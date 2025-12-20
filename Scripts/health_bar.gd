extends ProgressBar

func _process(delat : float) -> void :
	if (value != GameManager.current_life) :
		value = GameManager.current_life
	return
