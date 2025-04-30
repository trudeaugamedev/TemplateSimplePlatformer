extends CharacterBody2D
class_name amogi

@export var SPEED = 300.0
@export var HEALTH = 1
@export var JUMP_SPEED = -600.0 # Negative is up
@export var willTurn = true
@export var canJump = false
var direction = 1
var hasJumped = true

func _init():
	#constructor
	pass

func _ready():
	# Animation
	$AnimatedSprite2D.play("moving")

func _physics_process(delta: float) -> void:
	basic_movement(delta)

func basic_movement(delta: float):
	# Applies gravity
	gravity(delta)
	# Turns upon reaching edge
	turn()
	# Moves
	velocity.x = direction * SPEED
	move_and_slide() 

func gravity(delta: float):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() *  delta # bandage fix for slopes
	else:
		hasJumped = false

func jump():
	if not hasJumped:
		velocity.y = JUMP_SPEED

func flip():
	# Changes direction of the Amogi
	# Since direction is either 1 or -1, to switch direction, just make it the negative of the previous direction
	direction = -direction
	scale.x *= -1

func turn():
	if (!$Hitbox/DownRay.is_colliding() or $Hitbox/SideRay.is_colliding()) and is_on_floor() and willTurn:
		flip()

func _on_killbox_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	# If player jumps on the amogi, reduce health by 1. If it goes below 0 health, remove it from the scene.
	if body.is_in_group("player") && body.velocity.y > 0:
		body.jump()
		HEALTH -= 1
		if(HEALTH >= 0):
			queue_free()
