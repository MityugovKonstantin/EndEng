extends InteractiveObject

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
