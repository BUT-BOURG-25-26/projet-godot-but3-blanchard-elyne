extends HBoxContainer

@export var life_icon_scene : PackedScene
@onready var player: Player = $"../../Player"

func _ready() -> void:
	for i in range(player.current_life):
		var life_icon = life_icon_scene.instantiate()
		add_child(life_icon)

func _process(delta : float) -> void :
	if player.current_life != get_child_count():
		get_child((get_child_count()-1)).queue_free()
