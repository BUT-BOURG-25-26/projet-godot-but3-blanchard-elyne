extends Node3D

class_name AttackSpawner

@export var enemy_scenes : Array[PackedScene]

@onready var spawn_timers : Array[Timer] =[]

var player : Player
