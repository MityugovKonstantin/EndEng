extends StaticBody2D

class_name InteractiveObject

onready var choose_flag = $ChooseFlag

var is_active: bool = false
var is_died: bool = false
var hint: String = "ERROR hint"
var answer: String = "ERROR answer"

func _ready():
	select_question()

func kill():
	is_died = true

func select_question():
	pass

func get_hint():
	return hint

func get_answer():
	return answer

func enable():
	if is_active != true:
		is_active = true
	choose_flag.show()

func disable():
	if is_active != false:
		is_active = false
	select_question()
	choose_flag.hide()
