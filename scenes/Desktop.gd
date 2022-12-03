extends InteractiveObject

func create_random_question():
	randomize()
	var question_number = randi() % 1 + 1
	return question_number

func select_question():
	var question_number = create_random_question()
	match question_number:
		1:
			hint = "включить КОМПЬЮТЕР"
			answer = "computer"
		2:
			hint = "ВКЛЮЧИТЬ компьютер"
			answer = "turn on"
		3:
			hint = "ВЫКЛЮЧИТЬ компьютер"
			answer = "turn off"
		4:
			hint = "Посмотреть на МОНИТОР"
			answer = "monitor"
