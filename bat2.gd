extends CharacterBody2D

var speed: float = 3
var distance: float = 70
var moving_right: bool = true
var original_position: Vector2

func _ready():
	original_position = global_position

func _process(delta):
	$AnimatedSprite2D.play("flap")
	var target_position = original_position
	if moving_right:
		target_position.x += distance
	else:
		target_position.x -= distance

	if global_position.x >= target_position.x:
		moving_right = false
	elif global_position.x <= target_position.x:
		moving_right = true

	var direction = Vector2(1, 0)  # Move along the x-axis
	if not moving_right:
		direction.x = -1

	velocity = direction * speed
	
	move_and_collide(velocity)
