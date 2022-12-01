extends Spatial

onready var player = $Player

var is_paused: bool = false

func _ready():
	pass

func player_enable():
	print("[world -> player_enable]: player was enabled")
	player.is_active = true

func player_disable():
	print("[world -> player_enable]: player was disabled")
	player.is_active = false
