extends CharacterBody2D


const SPEED = 300.0
const JUMP_SPEED = -600.0
var direction = 1

func _ready():
	$AnimatedSprite2D.play("moving")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta #bandage fix for slopes
		
	if (!$Hitbox/DownRay.is_colliding() or $Hitbox/SideRay.is_colliding()) and is_on_floor():
		if ($Hitbox/SideRay.is_colliding()):
			jump()
		else: 
			flip()
		
	velocity.x = direction * SPEED
	move_and_slide() 

func jump():
	velocity.y = JUMP_SPEED

func flip():
	direction = -direction
	scale.x *= -1
