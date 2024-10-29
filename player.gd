extends CharacterBody2D


@export var  SPEED = 300.0
@export var  JUMP_VELOCITY = -600.0

var spawner = null

var was_on_floor
@export var hp = 2
var isDead = false

@onready var _animated_sprite = $AnimatedSprite2D
@onready var health_bar = $"in game UI/CanvasLayer/HealthBar"
@onready var coyote_timer = $CoyoteTimer	
@onready var death_timer = $DeathTimer

func _ready() -> void:
	#sets max value of the healthbar to hp upon starting
	isDead = false
	health_bar.max_value = hp


func _physics_process(delta: float) -> void:	
	#Animations
	if not isDead:
		if not is_on_floor():
			_animated_sprite.play("jump")
		elif Input.is_action_pressed("ui_right"):
			_animated_sprite.play("right")
		elif Input.is_action_pressed("ui_left"):
			_animated_sprite.play("left")
		else:
			_animated_sprite.play("idle")

		
	was_on_floor = is_on_floor()
	# Add the gravity. Manages Coyote Time
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") && (is_on_floor() || !coyote_timer.is_stopped()):
		jump()
	
	#Sets healthbar visuals to current HP
	health_bar.value = hp

	# stop all movements if character is dead
	if isDead:
		if(death_timer.is_stopped()):
			queue_free()
		return
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Move and slide is how the character moves.
	move_and_slide()
	
	#Start coyote timer if you are no longer on a platform
	if was_on_floor && !is_on_floor():
		coyote_timer.start()


func kill_self():
	hp = 0
	die()
	
func lose_health():
	hp -= 1
	if hp <= 0 && not isDead:
			die()
			
func gain_health():
	hp += 1
	
# Jump
func jump():
	velocity.y = JUMP_VELOCITY
	coyote_timer.stop()

# Death
func die():
	_animated_sprite.play("die")
	death_timer.start()
	isDead = true

func _on_hitbox_body_entered(body: Node2D) -> void:
	velocity.y = -100+JUMP_VELOCITY
	lose_health()
	if(body.is_in_group("instant_death")):
		kill_self()
