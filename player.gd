extends CharacterBody2D

## Character's health points (default: 100). When reaches 0, character dies.
@export var hp: int = 100

## Maximum health points for this character/object
@export var max_hp: int = 100

## Movement speed in units per second (default: 15). Affects all movement.
@export var speed: int = 15

## Reference to the AnimatedSprite2D node
@onready var player_animated: AnimatedSprite2D = $PlayerAnimated

# Current character condition (idle, walk, dead, corpse)
var condition: String = "idle"

# Character's facing direction (up, down, right)
var direction: String = "down"

# Character death flag
var die = false

func _ready() -> void:
	# Connect animation finished signal to handler
	player_animated.animation_finished.connect(_on_player_animated_animation_finished)

func _physics_process(delta: float) -> void:
	# Check health status
	if hp <= 0:
		dead()
	else:
		# Update health
		hp_player()
		# Handle movement
		move(delta)

	# Update animation
	anim()

	# Apply movement
	move_and_slide()

# Clamp health to maximum value
func hp_player():
	if hp > max_hp:
		hp = max_hp

# Handle character movement
func move(delta):
	# Get input vector from keyboard
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Calculate velocity (150 - arbitrary multiplier for speed adjustment)
	velocity = input_direction * speed * delta * 150

	# Determine condition and direction
	if input_direction.length() > 0:
		condition = "walk"

		# Determine dominant direction (horizontal vs vertical)
		if abs(input_direction.x) > abs(input_direction.y):
			# Right/left movement uses single animation with flip
			direction = "right"
			# Flip sprite for left movement
			player_animated.flip_h = input_direction.x < 0
		else:
			# Vertical movement
			if input_direction.y > 0:
				direction = "down"
			else:
				direction = "up"
	else:
		# Character is idle
		condition = "idle"

# Handle character death
func dead():
	if die == false:
		die = true
		condition = "dead"

# Update animation
func anim():
	# Build animation name from condition and direction
	player_animated.play(str(condition,'_',direction))

# Animation finished handler
func _on_player_animated_animation_finished() -> void:
	# After death animation switch to corpse state
	if condition == "dead":
		condition = "corpse"
