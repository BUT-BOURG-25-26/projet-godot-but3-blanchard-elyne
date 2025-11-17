class_name Player
extends CharacterBody3D

@export var move_speed:float = 5
@export var life: int = 5
@export var max_life : int = 5

var move_inputs: Vector2


func _physics_process(delta: float) -> void:
	read_move_inputs()
	move_inputs *= move_speed * delta
	
	var velocity = Vector3(move_inputs.x, 0.0, move_inputs.y)
	
	if  velocity != Vector3.ZERO:
		var look_at_point = global_position + (velocity*5.0)
		look_at(look_at_point)
		
	if move_inputs != Vector2.ZERO:
		global_position += velocity
	return


func read_move_inputs():
	move_inputs.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_inputs.y = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	move_inputs = move_inputs.normalized()
	return
