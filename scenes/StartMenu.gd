extends Control


func _ready():
	pass


func _on_LoadLevel_pressed():
	get_tree().change_scene_to(preload("res://scenes/World.tscn"))
	pass


func _on_Exit_pressed():
	get_tree().quit()
