extends Node

var current_axis = 0
var last_changed_axis = 0

func _ready():
	pass 

func _process(delta):
	debug_wolf_mode()
	debug_lighting()
	pass

func debug_wolf_mode():
	if Input.is_action_just_pressed("ui_select"):
		$Werewolf.switch_human()
	pass

func debug_lighting():
	if Input.is_action_pressed("ui_right"):
		$Light2D.position.x += 1
	elif Input.is_action_pressed("ui_left"):
		$Light2D.position.x -= 1
	
	pass
