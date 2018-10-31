extends Node

var dir = 1

func _ready():
	$GenericEnemy.patrol($Werewolf)
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
	var max_x = $Werewolf.position.x + 50
	var min_x = $Werewolf.position.x - 50
	if dir == 1:
		if $Moonlight.position.x < max_x:
			$Moonlight.position.x += 0.1
		elif $Moonlight.position.x >= max_x:
			dir = -1
	elif dir == -1:
		if $Moonlight.position.x > min_x:
			$Moonlight.position.x -= 0.1
		elif $Moonlight.position.x <= min_x:
			dir = 1
	pass