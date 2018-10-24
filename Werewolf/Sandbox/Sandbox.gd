extends Node


func _ready():
	pass 

func _process(delta):
	find_direction_axis()
	set_auto()
	pass

func find_direction_axis():
	if $PlayerControl.resultant_axis.has("N"):
		$Werewolf.horax = 0
		$Werewolf.vertax = -1
	elif $PlayerControl.resultant_axis.has("S"):
		$Werewolf.horax = 0
		$Werewolf.vertax = 1
	elif $PlayerControl.resultant_axis.has("E"):
		$Werewolf.horax = 1
		$Werewolf.vertax = 0
	elif $PlayerControl.resultant_axis.has("W"):
		$Werewolf.horax = -1
		$Werewolf.vertax = 0
	elif $PlayerControl.resultant_axis.has("NE"):
		$Werewolf.horax = 1
		$Werewolf.vertax = -1
	elif $PlayerControl.resultant_axis.has("NW"):
		$Werewolf.horax = -1
		$Werewolf.vertax = -1
	elif $PlayerControl.resultant_axis.has("SE"):
		$Werewolf.horax = 1
		$Werewolf.vertax = 1
	elif $PlayerControl.resultant_axis.has("SW"):
		$Werewolf.horax = -1
		$Werewolf.vertax = 1
	else:
		$Werewolf.horax = 0
		$Werewolf.vertax = 0
	pass

func set_auto():
	if $AutoMove.is_pressed():
		$PlayerControl.auto_enabled = true
	elif !($AutoMove.is_pressed()):
		$PlayerControl.auto_enabled = false
	pass