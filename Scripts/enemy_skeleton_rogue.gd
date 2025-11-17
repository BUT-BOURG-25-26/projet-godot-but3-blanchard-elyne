extends Enemy

class_name EnemySkeletonRogue

@onready var animation : AnimationSkeletonRogue = $Skeleton_Rogue


func _ready() -> void:
	super()


func _process(delta: float) -> void:
	if (animation.finished_dying) :
		destroy()


func move_pattern(delta: float) -> void :
	if (animation.is_spawning):
		return
	var move = Vector3(player.global_position.x-global_position.x,0.0,player.global_position.z-global_position.z).normalized()
	velocity = move * run_speed
	
	velocity.y = get_gravity().y
	
	look_at_position = player.global_position
	look_at(look_at_position)
	return

func die() -> void :
	animation.die()
