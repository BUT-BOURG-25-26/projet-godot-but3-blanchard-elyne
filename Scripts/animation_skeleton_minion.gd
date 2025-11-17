extends Node3D
class_name AnimationSkeletonMinion

var is_spawning : bool = true
var finished_dying = false

@onready var animation_tree: AnimationTree = $AnimationTree

func die() -> void :
	animation_tree.set("parameters/conditions/isDead",true)


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	print(anim_name)
	if (anim_name == "animation/Spawn_Ground"):
		is_spawning = false
	if (anim_name == "animation/Death_A") :
		finished_dying = true
