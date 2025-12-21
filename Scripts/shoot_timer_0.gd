extends Timer

signal timeout_indice(indice : int)

func _on_timeout() -> void:
	timeout_indice.emit(0)
