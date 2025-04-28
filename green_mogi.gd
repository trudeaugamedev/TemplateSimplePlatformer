extends "res://basic_enemy.gd"

@export var land_speed = 300
@onready var predict_ray = $PlayerPredict/PredictRay

func _physics_process(delta: float) -> void:
	super._physics_process(delta)

func _on_player_predict_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		jump()
		hasJumped = true
