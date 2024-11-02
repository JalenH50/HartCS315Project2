extends Node2D

@onready var Menu_player = $MenuPlayer
@onready var game_controller = get_node("../GameController")
@onready var menu_title = get_tree().get_root().get_node("Menu/Title")
@onready var LevelButton = get_tree().get_root().get_node("Menu/LevelButton")
@onready var Button1 = get_tree().get_root().get_node("Menu/Button1")
@onready var Button2 = get_tree().get_root().get_node("Menu/Button2")
@onready var ChooseALevel = get_tree().get_root().get_node("Menu/ChooseALevel")
@onready var Level1 = get_tree().get_root().get_node("res://Scenes/level1.tscn")
@onready var timer = $ChooseALevel/Timer
var visible_ratio: float = 0

func _ready():	
	Menu_player.play()
	ChooseALevel.set_visible_ratio(0.0)
	Button1.hide()
	Button2.hide()

func _on_level_select_button_pressed() -> void:
	LevelButton.hide()
	menu_title.hide()
	Button1.show()
	Button2.show()
	timer.start()
	
func update_label_visibility():
	ChooseALevel.set_visible_ratio(visible_ratio)

func _on_timer_timeout() -> void:
	visible_ratio +=0.1
	if visible_ratio >=1.0:
		visible_ratio = 1.0
		timer.stop()
	update_label_visibility()



func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level2.tscn")


func _on_button_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level1.tscn")
	pass # Replace with function body.
