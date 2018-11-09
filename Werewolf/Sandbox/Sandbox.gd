extends Node

var dir = 1

func _ready():
	$Werewolf/AnimationPlayer.play("Loading")
	loading()
	$Werewolf/AnimationPlayer.play("HumanIdle")
	pass 

func _process(delta):
	light_transform()
	walklight()
	pass

func light_transform():
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

func loading():
	$Werewolf.moonlight = $Moonlight
	$Enemies/GenericEnemy.player = $Werewolf
	$Enemies/GenericEnemy2.player = $Werewolf
	$Enemies/GenericEnemy3.player = $Werewolf
	$Enemies/GenericEnemy4.player = $Werewolf
	$Shepherds/Shepherd.player = $Werewolf
	$Church.player = $Werewolf
	pass