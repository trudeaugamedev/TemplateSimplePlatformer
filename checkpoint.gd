extends Node2D

@onready var spawn = get_tree().root.find_child("PlayerSpawn", true, false)
@onready var tilemap = get_tree().root.find_child("TileMapLayer", true, false)


func _on_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if(body.is_in_group("player")):
		spawn = get_tree().root.find_child("PlayerSpawn", true, false)
		spawn.position = position
