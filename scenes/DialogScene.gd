extends Popup



onready var lineEdit = $Window/LineEdit
onready var hint = $Window/Hint
onready var correct = $Window/Correct
onready var wrong = $Window/Wrong
onready var player = get_tree().get_root().get_node("path/World/Player")


var isShow: bool = false
var answer


func _ready():
	connect("sig_enable", self, "show")
	print("1")
	connect("sig_disable", self, "select_question")
	print("2")


func show():
	if isShow != true:
		get_tree().paused = true
		select_question()
		popup()
		lineEdit.grab_focus()
		isShow = true


func select_question():
	randomize()
	var questionNumber = randi() % 5 + 1
	match questionNumber:
		1:
			hint.text = "посмотреть под КРОВАТЬ"
			answer = "bed"
		2:
			hint.text = "посмотреть под ПОДУШКУ"
			answer = "pillow"
		3:
			hint.text = "посмотреть под ОДЕЯЛОМ"
			answer = "blanket"
		4:
			hint.text = "посмотреть под ПРОСТЫНЬЮ"
			answer = "sheets"
		5:
			hint.text = "ЗАПРАВИТЬ кровать"
			answer = "make"


func _on_LineEdit_text_entered(new_text):
	var text = new_text as String
	
	hint.hide()
	lineEdit.hide()
	
	if text.to_lower() == answer as String:
		correct.show()
		yield(get_tree().create_timer(5.0), "timeout")
		isShow = false
		correct.hide()
		hide()
	else:
		wrong.show()
		yield(get_tree().create_timer(5.0), "timeout")
		wrong.hide()
	
	hint.show()
	lineEdit.clear()
	lineEdit.show()
	lineEdit.grab_focus()
