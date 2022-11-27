extends Spatial

onready var player = $Player
onready var pauseMenu = $PauseMenu


var isPaused: bool = false


func _ready():
	pass


func player_enable():
	player.isActive = true


func player_disable():
	player.isActive = false
