extends StaticBody2D





onready var choose_flag = $ChooseFlag
onready var popup = $Popup


var isActive: bool = false


func get_input():
	if Input.is_action_just_released("ui_accept"):
		action()


func _physics_process(_delta):
	if isActive == true:
		get_input()


func enable():
	if isActive != true:
		isActive = true
	choose_flag.show()


func disable():
	if isActive != false:
		isActive = false
	choose_flag.hide()


func action():
	popup.show()
