extends Control

onready var world = preload("res://scenes/World.tscn")
onready var load_level = $LoadLevel
onready var exit_button = $Exit


func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_down"):
		exit_button.grab_focus()
	if Input.is_action_just_pressed("ui_up"):
		load_level.grab_focus()

func _on_LoadLevel_pressed():
	if world:
		get_tree().change_scene_to(world)
	else:
		print_debug("start_menu: world is null")
		get_tree().quit(-1)
	pass

func _on_Exit_pressed():
	get_tree().quit()
