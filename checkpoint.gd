extends Node2D

@onready var spawn = $"../PlayerSpawn"

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	spawn.position = position
