extends Area2D

signal openDoor2
signal keySFX
@onready var game_controller = get_node("../../GameController")

func _ready():
	pass

func _process(delta):
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		openDoor2.emit()
		keySFX.emit()
		queue_free()
