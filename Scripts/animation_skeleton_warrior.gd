extends Node3D
class_name AnimationSkeletonWarrior

var is_spawning : bool = true
var finished_dying = false
var is_getting_hit = false

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func die() -> void :
	animation_tree.set("parameters/conditions/isDead",true)

func run()	-> void :
	animation_tree.set("parameters/conditions/hit_to_run",false)
	animation_tree.set("parameters/conditions/hit_to_walk",false)
	animation_tree.set("parameters/conditions/isRunning",true)
	animation_tree.set("parameters/conditions/isWalking",false)

func walk() -> void :
	animation_tree.set("parameters/conditions/hit_to_run",false)
	animation_tree.set("parameters/conditions/hit_to_walk",false)
	animation_tree.set("parameters/conditions/isRunning",false)
	animation_tree.set("parameters/conditions/isWalking",true)

func hit() -> void :
	animation_tree.set("parameters/conditions/isRunning",false)
	animation_tree.set("parameters/conditions/isWalking",false)
	animation_tree.set("parameters/conditions/isHit",true)

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	print(anim_name)
	if (anim_name == "animation/Spawn_Ground"):
		is_spawning = false
	if (anim_name == "animation/Death_A") :
		finished_dying = true
	if (anim_name == "animation/Hit_A") :
		is_getting_hit = true
	if (anim_name == "animation/Running_A") :
		print("_on_animation_tree_animation_finished : Running_A")
		animation_tree.set("parameters/conditions/hit_to_run",true)
	if (anim_name == "animation/Walking_A") :
		print("_on_animation_tree_animation_finished : Walking_A")
		animation_tree.set("parameters/conditions/hit_to_walk",true)
