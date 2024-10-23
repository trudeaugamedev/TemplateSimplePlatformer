extends CharacterBody2D


const SPEED = 300.0
const JUMP_SPEED = -600.0
var direction = 1
var hasJumped = true;

func _ready():
	$AnimatedSprite2D.play("moving")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if (randi() % 20 == 1 && !hasJumped):
			jump() # chance of jumping in air once
			hasJumped = true
		else:
			velocity += get_gravity() * delta #bandage fix for slopes
	else:
		hasJumped = false;
		
	if (!$Hitbox/DownRay.is_colliding() or $Hitbox/SideRay.is_colliding()) and is_on_floor():
		if ($Hitbox/SideRay.is_colliding() && (randi() % 2 == 0)):
			jump()
		else: 
			if (randi() % 5 != 0):
				flip()
			else:
				jump()
		
	velocity.x = direction * SPEED
	move_and_slide() 

func jump():
	velocity.y = JUMP_SPEED

func flip():
	direction = -direction
	scale.x *= -1
