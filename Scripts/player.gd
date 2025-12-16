class_name Player
extends CharacterBody3D

@export var move_speed:float = 5
@export var current_life: int = 5
@export var max_life : int = 5
@export var shoot_intervals: Array[float]
@export var bullet_scenes : Array[PackedScene]
@export var invincibility_time : float = 0.5
@export var joystick_left : VirtualJoystick

@onready var shoot_timer : Timer = $ShootTimer
@onready var invicibility_timer : Timer = $InvincibilityTimer



var move_inputs: Vector2
var look_at_point : Vector3 = Vector3.FORWARD
var is_invincible = false

func _ready() -> void:
	shoot_timer.start(shoot_intervals.get(0))
	shoot_timer.timeout.connect(shoot)
	invicibility_timer.timeout.connect(on_invicibility_end)


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
	move_inputs = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	move_inputs = move_inputs.normalized()
	return


func shoot(): 
	var bullet = bullet_scenes.get(0).instantiate()
	bullet.global_position = global_position
	get_tree().current_scene.add_child(bullet)
	return

func take_damage(damage : int) -> void:
	if is_invincible || current_life <=0:
		return
	is_invincible = true
	current_life -= damage
	if (current_life<=0):
		GameManager.game_over()
	else :
		invicibility_timer.start(invincibility_time)
	print("current_life : ",current_life)


func on_invicibility_end():
	is_invincible = false
