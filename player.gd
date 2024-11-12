extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -600.0

@export var hp = 2
var spawner = null
var isDead = false

@onready var animation = $Animation
@onready var health_bar = get_tree().root.find_child("HealthBar", true, false)
@onready var death_timer = $DeathTimer

func _ready() -> void:
	#sets max value of the healthbar to hp upon starting
	isDead = false
	health_bar.max_value = hp


func _physics_process(delta: float) -> void:
	#Animations
	if not isDead:
		pass

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Add jump.
	# Add another condition to be able to jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump()
	
	# Sets healthbar visuals to current HP
	health_bar.value = hp

	# Stop all movements if character is dead
	if isDead:
		if death_timer.is_stopped():
			queue_free()
		return
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED
	# Move and slide is how the character moves.
	move_and_slide()


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

# Death
func die():
	death_timer.start()
	isDead = true


func _on_hurtbox_body_entered(body: Node2D) -> void:
	lose_health()
	if body.is_in_group("instant_death"):
		kill_self()
