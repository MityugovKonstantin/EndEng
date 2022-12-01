extends Control

onready var continue_button = $Sprite/Continue
onready var exit_button = $Sprite/Exit

var is_palyer_was_disable_to_pause: bool = false

onready var world = get_tree().get_root().get_node("/root/World")

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if world.player.is_active:
			is_palyer_was_disable_to_pause = true
			world.player_disable()
		else:
			is_palyer_was_disable_to_pause = false
		continue_button.grab_focus()
		show()
	if Input.is_action_just_pressed("ui_down"):
		exit_button.grab_focus()
	if Input.is_action_just_pressed("ui_up"):
		continue_button.grab_focus()

func _on_Continue_pressed():
	if is_palyer_was_disable_to_pause:
		world.player_enable()
	hide()

func _on_Exit_pressed():
	var start_menu = load("res://scenes/StartMenu.tscn")
	if start_menu:
		var change_scene_error = get_tree().change_scene_to(start_menu)
		print("[pause_menu -> _on_Exit_pressed]: chanche_scene_to return " + String(change_scene_error))
	else:
		print("[pause_menu -> _on_Exit_pressed]: start_menu is null")
