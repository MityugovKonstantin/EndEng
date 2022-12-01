extends StaticBody2D

onready var choose_flag = $ChooseFlag

var is_active: bool = false
var is_died: bool = false
var hint: String = "ERROR hint"
var answer: String = "ERROR answer"

func _ready():
	select_question()

func kill():
	is_died = true

func create_random_question():
	randomize()
	var question_number = randi() % 5 + 1
	return question_number

func select_question():
	var question_number = create_random_question()
	match question_number:
		1:
			hint = "посмотреть под КРОВАТЬ"
			answer = "bed"
		2:
			hint = "посмотреть под ПОДУШКУ"
			answer = "pillow"
		3:
			hint = "посмотреть под ОДЕЯЛОМ"
			answer = "blanket"
		4:
			hint = "посмотреть под ПРОСТЫНЬЮ"
			answer = "sheets"
		5:
			hint = "ЗАПРАВИТЬ кровать"
			answer = "make"

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
