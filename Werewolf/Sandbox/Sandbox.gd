extends Node

func _ready():
	pass 

func _process(delta):
	debug_wolf_mode()
	debug_lighting()
	debug_raycasting()
	walklight()
	pass

func debug_wolf_mode():
	if Input.is_action_just_pressed("ui_select"):
		$Werewolf.switch_human()
	pass

func debug_lighting():
	if Input.is_action_pressed("ui_right"):
		$Moonlight.position.x += 1
	elif Input.is_action_pressed("ui_left"):
		$Moonlight.position.x -= 1
	pass

func debug_raycasting():
	if $Moonlight.check_if_object($Werewolf):
		$Moonlight.detect_enabled = false
		$Werewolf.switch_human()
	pass

func walklight():
	$Moonlight.position.y = $Werewolf.position.y - 300
	pass