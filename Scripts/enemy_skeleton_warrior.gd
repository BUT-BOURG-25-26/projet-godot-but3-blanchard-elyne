extends Enemy

class_name EnemySkeletonWarrior

@onready var animation : AnimationSkeletonWarrior = $Skeleton_Warrior

@export var w_speed:int = 5
@export var m_life:int = 3
@export var damage :int = 5
@export var s_value:int = 4
@export var distance_start_running = 30
@export var running_time = 4

var is_running : bool= false


func _ready() -> void:
	super()
	run_speed = player.move_speed
	walk_speed=w_speed
	max_life= m_life
	damages = damage
	score_value =s_value
	current_life = max_life

func _process(delta: float) -> void:
	if (animation.finished_dying) :
		destroy()


func move_pattern(delta: float) -> void :
	if (animation.is_spawning || animation.is_getting_hit):
		return
	
	if (!is_running && calculate_distance_from_player() < distance_start_running):
		print("start running")
		var move = Vector3(player.global_position.x-global_position.x,0.0,player.global_position.z-global_position.z).normalized()
		velocity = move * run_speed
		start_running()
	if (is_running && calculate_distance_from_player() > distance_start_running + 5):
		stop_running()

	if (!is_running) :
		var move = Vector3(player.global_position.x-global_position.x,0.0,player.global_position.z-global_position.z).normalized()
		velocity = move * walk_speed
		look_at_position = player.global_position
		look_at(look_at_position)
	
	velocity.y = get_gravity().y
	return

func die() -> void :
	animation.die()

func take_damage(damages : int) -> void :
	is_running = false
	animation.hit()

func start_running() -> void :
	is_running = true
	animation.run()
	return

func stop_running() -> void :
	is_running = false
	animation.walk()
	return

func calculate_distance_from_player() -> float :
	var x = (player.global_position.x-global_position.x)
	var z = (player.global_position.z-global_position.z)
	return sqrt(x*x+z*z)
