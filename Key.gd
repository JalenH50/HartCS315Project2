extends Area2D

signal openDoor
signal keySFX
@onready var game_controller = get_node("../../GameController")

func _ready():
	pass

func _process(delta):
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		openDoor.emit()
		keySFX.emit()
		queue_free()
