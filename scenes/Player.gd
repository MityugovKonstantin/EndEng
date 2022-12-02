extends KinematicBody2D

signal sig_enable(hint, answer)
signal sig_disable

onready var sprite = $Sprite
onready var interactive_collision = $InteractiveObjectDetected/InteractiveCollision

var r: Reference = null
var speed = 100
var velocity = Vector2()
var is_active: bool = true

func get_dialog_scene():
	var dialog_scene = get_tree().get_root().get_node("/root/World/DialogScene")
	if dialog_scene:
		return dialog_scene 
	else:
		print("[palyer -> init]: dialog scene is null")

func init():
	var dialog_scene = get_dialog_scene()
	dialog_scene.connect("interactive_object_is_die", self, "kill_object")
	print("[player -> init]: method kill_object was connected to interactive_object_is_die signal")

func _ready():
	call_deferred("init")

func kill_object():
	if r != null:
		r.get_ref().kill()
	else:
		print("[player -> kill_object]: object is null")

func get_move_input():	
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		sprite.texture = preload("res://sprites/player/player_right.png")
		interactive_collision.rotation = -90
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		sprite.texture = preload("res://sprites/player/player_left.png")
		interactive_collision.rotation = 90
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		sprite.texture = preload("res://sprites/player/player_front.png")
		interactive_collision.rotation = 0
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		sprite.texture = preload("res://sprites/player/player_back.png")
		interactive_collision.rotation = 180
	velocity = velocity.normalized() * speed

func get_accept_input():
	if r != null:
		if r.get_ref().is_died == false:
			if Input.is_action_just_pressed("ui_accept"):
				var dialog_scene = get_dialog_scene()
				dialog_scene.interuct()

func _physics_process(_delta):
	get_accept_input()
	if is_active:
		get_move_input()
	velocity = move_and_slide(velocity)

func _on_InteractiveObjectDetected_body_entered(object):
	print("[player -> ..._body_entered]: body is " + object.name)
	if object is InteractiveObject:
		if object != self:
			if object.is_died != true:
				if object != null:
					if r == null:
						r = weakref(object)
						var hint = object.get_hint()
						var answer = object.get_answer()
						print("[player -> ..._body_entered]: hint = " + hint)
						print("[player -> ..._body_entered]: answer = " + answer)
						if !object.is_died:
							emit_signal("sig_enable", hint, answer)
							if object.has_method("enable"):
								object.enable()
							else:
								print("[player -> ..._body_entered]: object haven't .enable method")
						else:
							print("[player -> ..._body_entered]: object died, can't enable")
			else:
				print("[palyer -> ..._body_entered]: collision no active because object is died")

func _on_InteractiveObjectDetected_body_exited(body):
	print("[player -> ..._body_exited]: body is " + body.name)
	if body is InteractiveObject:
	#if body != self:
		if body.has_method("disable"):
			body.disable()
		else:
			print("[player -> ..._body_exited]: object haven't .disable method")
		if body.is_died != true:
			emit_signal("sig_disable")
			r = null
		else:
			print("[palyer -> ..._body_exited]: collision no active because object is died")
