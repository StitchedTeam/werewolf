extends Node


func _ready():
	pass

func _process(delta):
	pause()
	pass

func pause():
	if $CanvasLayer/UI/PauseButton.pressed:
		get_tree().paused = !get_tree().paused
	pass