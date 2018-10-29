extends Node

var current_axis = 0
var last_changed_axis = 0

func _ready():
	pass 

func _process(delta):
	find_direction_axis()
	debug_wolf_mode()
	debug_lighting()
	pass

func find_direction_axis():
	if $PlayerControl.resultant_axis.has("1"):
		$Werewolf.set_axis(1)
	elif $PlayerControl.resultant_axis.has("2"):
		$Werewolf.set_axis(2)
	elif $PlayerControl.resultant_axis.has("3"):
		$Werewolf.set_axis(3)
	elif $PlayerControl.resultant_axis.has("4"):
		$Werewolf.set_axis(4)
	elif $PlayerControl.resultant_axis.has("5"):
		$Werewolf.set_axis(5)
	elif $PlayerControl.resultant_axis.has("6"):
		$Werewolf.set_axis(6)
	elif $PlayerControl.resultant_axis.has("7"):
		$Werewolf.set_axis(7)
	elif $PlayerControl.resultant_axis.has("8"):
		$Werewolf.set_axis(8)
	else:
		$Werewolf.set_axis(0)
	
	if $PlayerControl.auto_enabled:
		$Werewolf.speed = 5
	else:
		$Werewolf.speed = 20
	
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