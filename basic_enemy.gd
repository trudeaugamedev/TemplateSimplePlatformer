extends CharacterBody2D

@export var SPEED = 300.0
@export var HEALTH = 1
@export var JUMP_SPEED = -600.0 # Negative is up
var direction = 1
var hasJumped = true
@export var canJump = false


func _ready():
	# Animation
	$AnimatedSprite2D.play("moving")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
			velocity += get_gravity() * delta # bandage fix for slopes
	else:
		hasJumped = false
	turn()
	velocity.x = direction * SPEED
	move_and_slide() 

func jump():
	velocity.y = JUMP_SPEED

func flip():
	direction = -direction
	scale.x *= -1

func turn():
	if (!$Hitbox/DownRay.is_colliding() or $Hitbox/SideRay.is_colliding()) and is_on_floor():
		flip()
		#if $Hitbox/SideRay.is_colliding() && (randi() % 2 == 0) && canJump:
			#jump()
		#else: 
			#flip()
			#if randi() % 5 != 0 || !canJump:
				#flip()
			#else:
				#jump()

func _on_killbox_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("player") && body.velocity.y > 0:
		body.jump()
		HEALTH -= 1
		if(HEALTH == 0):
			queue_free()
