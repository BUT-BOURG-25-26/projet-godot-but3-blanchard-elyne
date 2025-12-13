extends Node3D

class_name WorldGenerator

@export var chunk_scenes : Array[PackedScene]

var loaded_chunks = {}
var chunk_size = Vector2(80,80)
var current_chunk

var player : Player
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	update_chunks()


func _process(delta: float) -> void:
	update_chunks()

func update_chunks():
	var player_chunk = Vector2(int(player.position.x / chunk_size.x),int(player.position.y / chunk_size.y))
	if player_chunk != current_chunk :
		current_chunk = player_chunk
		var chunks_to_loads = get_chunk_to_load(player_chunk)
		for chunk_coords in chunks_to_loads:
			if chunk_coords not in loaded_chunks:
				load_chunk(chunk_coords) 
		var keys_to_unloads = []
		for chunk_coords in loaded_chunks.keys():
			if chunk_coords not in chunks_to_loads:
				keys_to_unloads.append(chunk_coords)
		for chunk_coords in keys_to_unloads:
			unload_chunk(chunk_coords)
	return
	

func get_chunk_to_load(player_chunk):
	var chunks_to_load = []
	# grille établie : 5 par 5 (à voir comment on réparti et combien de chunk on met
	for x in range (player_chunk.x -2, player_chunk.y +3):
		for y in range (player_chunk.y -2, player_chunk.y +3):
			chunks_to_load.append(Vector2(x,y))
	return chunks_to_load

func load_chunk(chunk_coords): 
	var chunk_scene = get_chunk_scene(chunk_coords)
	var chunk_global_x = chunk_coords.x * chunk_size.x + (chunk_size.x/2)
	var chunk_global_z =  chunk_coords.y * chunk_size.y + (chunk_size.y/2)
	add_child(chunk_scene)
	chunk_scene.global_position.x = chunk_global_x
	chunk_scene.global_position.z = chunk_global_z
	print("chunk_scene.global_position : ",chunk_scene.global_position)
	loaded_chunks[chunk_coords] = chunk_scene


func unload_chunk(chunk_coords):
	var chunk = loaded_chunks[chunk_coords]
	if chunk :
		chunk.queue_free()
		loaded_chunks.erase(chunk_coords)
	


func get_chunk_scene(chunk_coords):
	var indice_scene = rng.randi_range(0,chunk_scenes.size()-1)
	return chunk_scenes.get(indice_scene).instantiate()
