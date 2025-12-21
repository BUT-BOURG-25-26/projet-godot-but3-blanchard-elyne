extends HBoxContainer

@export var life_icon_scene : PackedScene

@onready var animation_player : AnimationPlayer = $"../LifeHolderAnimationPlayer"
@onready var animation_timer : Timer = $"../LifeHolderAnimationTimer"
@onready var player: Player = $"../../Player"

func _ready() -> void:
	for i in range(player.current_life):
		var life_icon = life_icon_scene.instantiate()
		add_child(life_icon)

func _process(delta : float) -> void :
	if player.current_life < get_child_count():
		var life_delta = get_child_count() - player.current_life
		animation_player.play("take_damage")
		animation_timer.start(1)
		for i in life_delta :
			get_child((get_child_count()-1)).queue_free()
	if player.current_life > get_child_count() :
		var life_delta = player.current_life - get_child_count()
		animation_player.play("gain_life")
		animation_timer.start(1)
		for i in life_delta :
			var life_icon = life_icon_scene.instantiate()
			add_child(life_icon)


func _on_life_holder_animation_timer_timeout() -> void:
	animation_player.play("RESET")
	animation_player.stop()
