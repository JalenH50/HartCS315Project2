extends CharacterBody2D

var speed: float = 3
var distance: float = 70
var moving_up: bool = true
var original_position: Vector2

func _ready():
	original_position = global_position

func _process(delta):
	$AnimatedSprite2D.play("flap")
	var target_position = original_position
	if moving_up:
		target_position.y -= distance
	else:
		target_position.y += distance

	if global_position.y <= target_position.y:
		moving_up = false
	elif global_position.y >= target_position.y:
		moving_up = true

	var direction = Vector2(0, -1)
	if not moving_up:
		direction.y = 1


	velocity = direction * speed
	
	move_and_collide(velocity)
