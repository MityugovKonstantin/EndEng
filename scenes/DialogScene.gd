extends Popup

signal interactive_object_is_die

onready var line_edit = $Window/LineEdit
onready var hint_scene = $Window/Hint
onready var correct = $Window/Correct
onready var wrong = $Window/Wrong

var is_show: bool = false
var is_availble: bool = false
var correct_answer: String

func _ready():
	call_deferred("init")

func init():
	var player = get_player()
	player.connect("sig_enable", self, "enable")
	player.connect("sig_disable", self, "disable")

func get_player():
	var world = get_tree().get_root().get_node("/root/World")
	if world:
		if world.player:
			return world.player
		else:
			print("[dialog_scened -> get_player]: in world player == null")
	else:
		print("[dialog_scened -> get_player]: world == null")

# Активирует popup для открытия и устанавливает необходимые значения 
func enable(var hint: String, var inputed_answer: String):
	is_availble = true
	hint_scene.text = hint
	correct_answer = inputed_answer
	print("[dialog_scened -> enable]: dialog_scene already enabled")

# Диактивирует popup для открытия
func disable():
	is_availble = false
	print("[dialog_scened -> disable]: dialog_scene already disabled")

# Отключаем движение персонажа
func disable_player():
	var player = get_player()
	player.is_active = false

func enable_player():
	var player = get_player()
	player.is_active = true

func interuct():
	if is_availble:
		if is_show:
			print("[dialog_scene -> _phusics_process]: dialog_scene already shown")
		else:
			is_show = true
			disable_player()
			line_edit.grab_focus() # Перетащить внимание на себя
			popup()
			print("[dialog_scene -> _phusics_process]: dialog_scene successfully shown")

# Событие выполняющееся про нажатии enter
func _on_LineEdit_text_entered(new_text):
	var user_answer = new_text as String
	print("[dialog_scened -> ...text_entered]: user_answer = " + user_answer)
	hint_scene.hide()
	line_edit.hide()
	if user_answer.to_lower() == correct_answer as String:
		correct.show()
		yield(get_tree().create_timer(5.0), "timeout")
		hide()
		correct.hide()
		is_show = false
		emit_signal("interactive_object_is_die")
		enable_player()
	else:
		wrong.show()
		yield(get_tree().create_timer(5.0), "timeout")
		wrong.hide()
	hint_scene.show()
	line_edit.clear()
	line_edit.show()
	line_edit.grab_focus()
