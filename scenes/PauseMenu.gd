extends Control


onready var continueButton = $Sprite/Continue
onready var exitButton = $Sprite/Exit


onready var world = get_tree().get_root().get_node("/root/World")


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		world.player_disable()
		continueButton.grab_focus()
		show()
	
	if Input.is_action_just_pressed("ui_down"):
		exitButton.grab_focus()
	if Input.is_action_just_pressed("ui_up"):
		continueButton.grab_focus()


func _on_Continue_pressed():
	world.player_enable()
	hide()


func _on_Exit_pressed():
	
	# Save last checkpoint

	get_tree().change_scene_to(preload("res://scenes/StartMenu.tscn"))
