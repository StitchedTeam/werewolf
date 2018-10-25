extends Node


func _ready():
	pass 

func _process(delta):
	find_direction_axis()
	pass

func find_direction_axis():
	if $PlayerControl.resultant_axis.has("1"):
		$Werewolf.horax = 0
		$Werewolf.vertax = -1
	elif $PlayerControl.resultant_axis.has("2"):
		$Werewolf.horax = 0
		$Werewolf.vertax = 1
	elif $PlayerControl.resultant_axis.has("3"):
		$Werewolf.horax = 1
		$Werewolf.vertax = 0
	elif $PlayerControl.resultant_axis.has("4"):
		$Werewolf.horax = -1
		$Werewolf.vertax = 0
	elif $PlayerControl.resultant_axis.has("5"):
		$Werewolf.horax = 1
		$Werewolf.vertax = -1
	elif $PlayerControl.resultant_axis.has("6"):
		$Werewolf.horax = -1
		$Werewolf.vertax = -1
	elif $PlayerControl.resultant_axis.has("7"):
		$Werewolf.horax = 1
		$Werewolf.vertax = 1
	elif $PlayerControl.resultant_axis.has("8"):
		$Werewolf.horax = -1
		$Werewolf.vertax = 1
	else:
		$Werewolf.horax = 0
		$Werewolf.vertax = 0
	
	if $PlayerControl.auto_enabled:
		$Werewolf.speed = 5
	else:
		$Werewolf.speed = 20
	
	pass