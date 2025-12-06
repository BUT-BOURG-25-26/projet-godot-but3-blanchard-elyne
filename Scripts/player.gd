class_name Player
extends CharacterBody3D

@export var move_speed:float = 5
@export var current_life: int = 5
@export var max_life : int = 5
@export var shoot_intervals: Array[float]
@export var bullet_scenes : Array[PackedScene]

@onready var shoot_timer : Timer = $ShootTimer

var move_inputs: Vector2
var look_at_point : Vector3 = Vector3.FORWARD

func _ready() -> void:
	shoot_timer.start(shoot_intervals.get(0))
	shoot_timer.timeout.connect(shoot)


func _physics_process(delta: float) -> void:
	read_move_inputs()
	move_inputs *= move_speed * delta
	
	var velocity = Vector3(move_inputs.x, 0.0, move_inputs.y)
	
	if  velocity != Vector3.ZERO:
		look_at_point = global_position + (velocity*5.0)
		look_at(look_at_point)
		
	if move_inputs != Vector2.ZERO:
		global_position += velocity
	
	return
	


func read_move_inputs():
	move_inputs.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_inputs.y = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	move_inputs = move_inputs.normalized()
	return


func shoot(): 
	var bullet = bullet_scenes.get(0).instantiate()
	bullet.global_position = global_position
	get_tree().current_scene.add_child(bullet)
	return

func take_damage(damage : int) -> void:
	current_life -= damage
	if (current_life<=0):
		GameManager.game_over()
	print(current_life)
