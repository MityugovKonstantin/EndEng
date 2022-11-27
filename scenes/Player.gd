extends KinematicBody2D


signal sig_enable
signal sig_disable


onready var sprite = $Sprite
onready var interactiveCollision = $InteractiveObjectDetected/InteractiveCollision


var r: Reference = null
var speed = 100
var velocity = Vector2()
var isActive: bool = true


func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		sprite.texture = preload("res://sprites/player/player_right.png")
		interactiveCollision.rotation = -90
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		sprite.texture = preload("res://sprites/player/player_left.png")
		interactiveCollision.rotation = 90
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		sprite.texture = preload("res://sprites/player/player_front.png")
		interactiveCollision.rotation = 0
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		sprite.texture = preload("res://sprites/player/player_back.png")
		interactiveCollision.rotation = 180
	velocity = velocity.normalized() * speed


func _physics_process(_delta):
	if isActive:
		get_input()
	velocity = move_and_slide(velocity)


func _on_InteractiveObjectDetected_body_entered(body):
	if body.has_method('enable'):
		if r == null:
			r = weakref(body)
			emit_signal("sig_enable")
			body.enable()


func _on_InteractiveObjectDetected_body_exited(body):
	if body.has_method('disable'):
		body.disable()
		emit_signal("sig_disable")
		r = null
