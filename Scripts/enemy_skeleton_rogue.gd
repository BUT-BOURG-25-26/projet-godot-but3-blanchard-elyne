extends Enemy

class_name EnemySkeletonRogue

@onready var animation : AnimationSkeletonRogue = $Skeleton_Rogue

@export var r_speed:int = 4
@export var w_speed:int = 2
@export var m_life:int = 1
@export var damage :int = 1
@export var s_value:int = 2


func _ready() -> void:
	super()
	run_speed = r_speed
	walk_speed=w_speed
	max_life= m_life
	damages = damage
	score_value =s_value
	current_life = max_life

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
