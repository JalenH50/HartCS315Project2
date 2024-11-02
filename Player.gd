extends CharacterBody2D

@onready var jump_player = $JumpSound
@onready var Exit_player = $ExitPlayer
const SPEED = 200.0
var JUMP_VELOCITY = -450
var climbing:bool = false
var climbSpeed = 70
var Menu = preload("res://Scenes/Menu.tscn")

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	
	if climbing:
		$AnimatedSprite2D.play("climb")
	elif abs(velocity.x) > .1 and abs(velocity.y) < .1 and $AnimatedSprite2D.animation != "walk":
		$AnimatedSprite2D.play("walk")
	elif abs(velocity.x) < .1 and abs(velocity.y) < .1 and $AnimatedSprite2D.animation != "idle":
		$AnimatedSprite2D.play("idle")
		
		
	if(velocity.x > 0):
		$AnimatedSprite2D.scale.x = .25
	elif (velocity.x < 0):
		$AnimatedSprite2D.scale.x = -.25

func _physics_process(delta):
	if not is_on_floor() and not climbing:
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_player.play()
		
		
	if climbing:
		velocity.x = 0
		if Input.is_action_pressed("climbUp"):
			velocity.y = -climbSpeed
		if Input.is_action_pressed("climbDown"):
			velocity.y = climbSpeed
	
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()


func _on_ladder_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		climbing = true
	pass


func _on_ladder_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		climbing = false
	pass


func _on_key_body_entered(body: Node2D) -> void:
	pass


func _on_exit_door_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Exit_player.play()
		get_tree().change_scene_to_packed(Menu)
	pass 


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		JUMP_VELOCITY = -1000
		pass


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		JUMP_VELOCITY = -450
		pass


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"): 
		var bat_position = global_position 
		var player_position = body.global_position

		var direction = (player_position - bat_position).normalized()
		
		body.velocity += direction * 5
