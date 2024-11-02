extends Node

@onready var key_sound_player = $KeySound
@onready var Music_player = $Music
@onready var Menu = preload("res://Scenes/Menu.tscn")
@onready var Level1 = preload("res://Scenes/Level1.tscn")
@onready var Level2 = preload("res://Scenes/Level2.tscn")
var key_scene = preload("res://key.tscn")
var door_scene = preload("res://door.tscn")
var door_instance: Node  # This should store the instance of the door
@onready var timer = $"../npcZone/TextTimer"
@onready var NeedAKey = get_tree().get_root().get_node("Node2D/npcZone/NeedAKey")
@onready var FoundAKey = get_tree().get_root().get_node("Node2D/npcZone/FoundAKey")
var visible_ratio: float = 0
var hasKey: bool = false

func _ready():
	pass
	
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
	update_label_visibility()

func _on_key_open_door() -> void:
	$"../Door".queue_free()
	hasKey = true
	pass # Replace with function body.
	
func _on_key_2_open_door_2() -> void:
	$"../Door".queue_free()
	$"../Door2".queue_free()
	$"../Door3".queue_free()
	$"../Door4".queue_free()
	hasKey = true
	pass # Replace with function body.


func _on_key_2_key_sfx() -> void:
	print("play sound")
	key_sound_player.play()


func _on_key_key_sfx() -> void:
	print("play sound")
	key_sound_player.play()
