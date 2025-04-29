extends amogi

@export var dash_speed = 800
@export var regular_speed = 150
@onready var predict_ray = $PlayerPredict/PredictRay
@onready var dash_timer = $DashTimer
@onready var wait_timer = $WaitTimer
var is_dashing = false
var is_waiting = false


func _physics_process(delta: float) -> void:
	if dash_timer.is_stopped() && wait_timer.is_stopped() && is_dashing:
		is_dashing = false
		willTurn = true
		SPEED = regular_speed
		$AnimatedSprite2D.play("moving")
	elif wait_timer.is_stopped() && is_waiting:
		$AnimatedSprite2D.play("dash")
		is_dashing = true
		is_waiting = false
		willTurn = false
		dash_timer.start()
		SPEED = dash_speed
	else:
		super._physics_process(delta)

func _on_player_predict_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$AnimatedSprite2D.play("dashprepare")
		SPEED = 0
		is_waiting = true
		wait_timer.start()
