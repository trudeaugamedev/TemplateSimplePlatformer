extends Node2D

var player_scene = preload("res://player.tscn")
var player = null

@onready var sprite = $AnimatedSprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite.play("default")
	if player == null:
		var new_obj = player_scene.instantiate()
		new_obj.position = position
		new_obj.spawner = self
		get_parent().add_child(new_obj)
		player = new_obj
