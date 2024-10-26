extends Node2D

@onready var spawn = get_tree().root.find_child("PlayerSpawn", true, false)
@onready var tilemap = get_tree().root.find_child("TileMapLayer", true, false)

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if(body.is_in_group("player")):
		spawn.position = tilemap.map_to_local(tilemap.local_to_map(position))
