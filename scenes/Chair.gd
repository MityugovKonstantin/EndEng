extends InteractiveObject

func create_random_question():
	randomize()
	var question_number = randi() % 1 + 1
	return question_number

func select_question():
	var question_number = create_random_question()
	match question_number:
		1:
			hint = "посмотреть под СТУЛ"
			answer = "chair"
