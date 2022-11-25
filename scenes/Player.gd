extends KinematicBody2D

var speed = 100
var velocity = Vector2()
onready var sprite = $Sprite

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		sprite.texture = load("res://sprites/player/player_right.png")
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		sprite.texture = load("res://sprites/player/player_left.png")
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		sprite.texture = load("res://sprites/player/player_front.png")
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		sprite.texture = load("res://sprites/player/player_back.png")
	velocity = velocity.normalized() * speed

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)
