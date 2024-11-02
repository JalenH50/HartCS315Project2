extends Node

@onready var Menu = preload("res://Scenes/Menu.tscn")
@onready var Level1 = preload("res://Scenes/Level1.tscn")
var key_scene = preload("res://key.tscn")
var door_scene = preload("res://door.tscn")
var door_instance: Node  # This should store the instance of the door
@onready var timer = $"../npcZone/TextTimer"
@onready var NeedAKey = get_tree().get_root().get_node("Node2D/npcZone/NeedAKey")
@onready var FoundAKey = get_tree().get_root().get_node("Node2D/npcZone/FoundAKey")
var visible_ratio: float = 0
var hasKey: bool = false

func _ready():
	spawnLevel1()

func _process(delta):
	pass

func open_door():
	if door_instance:  # Ensure the door instance is valid
		door_instance.queue_free()  # Remove the door from the scene
		hasKey = true  # Update any relevant game state

func spawn_key(position: Vector2):
	var key_instance = key_scene.instantiate()
	key_instance.position = position
	add_child(key_instance)

func spawn_door(position: Vector2):
	door_instance = door_scene.instantiate()  # Assign to the class variable
	door_instance.position = position
	add_child(door_instance)  # Add the door to the scene

func _on_npc_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		timer.start()

func _on_text_timer_timeout() -> void:
	visible_ratio += 0.1
	if visible_ratio >= 1.0:
		visible_ratio = 1.0
		timer.stop()
	update_label_visibility()

func update_label_visibility():
	if not hasKey:
		NeedAKey.set_visible_ratio(visible_ratio)
	if hasKey:
		FoundAKey.set_visible_ratio(visible_ratio)

func _on_npc_zone_body_exited(body: Node2D) -> void:
	visible_ratio = 0.0
	NeedAKey.set_visible_ratio(0.0)
	FoundAKey.set_visible_ratio(0.0)

func spawnLevel1() -> void:
	spawn_key(Vector2(168, 92))
	spawn_door(Vector2(1017, 594))
	NeedAKey.set_visible_ratio(0.0)
	FoundAKey.set_visible_ratio(0.0)
