extends CharacterBody3D
class_name Enemy

@export var run_speed : int = 4
@export var walk_speed : int = 2
@export var max_life : int = 1
@export var current_life : int = 1
@export var damages : int = 1
@export var score_value : int = 1
var is_dying = false


var player : Player
var look_at_position

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	look_at_position = player.global_position
	look_at(look_at_position)


func _physics_process(delta: float) -> void:
	move_pattern(delta)
	move_and_slide()
	if (!is_dying) :
		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			var collider = collision.get_collider()
			if collider is Player:
				(collider as Player).take_damage(damages)
				die()
				break


func move_pattern(delta: float) -> void :
	pass

func die() -> void :
	is_dying = true
	

func destroy() -> void:
	GameManager.increase_score(score_value)
	queue_free()

func take_damage(damage : int) -> void:
	current_life -= damage
	if (current_life<=0):
		die()
