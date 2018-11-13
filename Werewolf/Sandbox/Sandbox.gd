extends Node

var dir = 1

var light_speed = 0

func _ready():
	$Werewolf/AnimationPlayer.play("Loading")
	loading()
	pass 

func _process(delta):
	light_transform()
	walklight()
	player_area()
	pass

func light_transform():
	if $Moonlight.check_if_object($Werewolf):
		$Moonlight.detect_enabled = false
		$Werewolf.switch_human()
	pass

func walklight():
	if $Werewolf.axis == 0:
		light_speed = 0.1
	else:
		light_speed = 0.3
	
	$Moonlight.position.y = $Werewolf.position.y - 300
	var max_x = $Werewolf.position.x + 40
	var min_x = $Werewolf.position.x - 40
	if dir == 1:
		if $Moonlight.position.x < max_x:
			$Moonlight.position.x += light_speed
		elif $Moonlight.position.x >= max_x:
			dir = -1
	elif dir == -1:
		if $Moonlight.position.x > min_x:
			$Moonlight.position.x -= light_speed
		elif $Moonlight.position.x <= min_x:
			dir = 1
	pass

func player_area():
	if $Areas/Area1.overlaps_body($Werewolf):
		if $Werewolf.area != 1:
			$Werewolf.area = 1
			$Werewolf.update_area()
	elif $Areas/Area2.overlaps_body($Werewolf):
		if $Werewolf.area != 2:
			$Werewolf.area = 2
			$Werewolf.update_area()
	elif $Areas/Area3.overlaps_body($Werewolf):
		if $Werewolf.area != 3:
			$Werewolf.area = 3
			$Werewolf.update_area()
	elif $Areas/Area4.overlaps_body($Werewolf):
		if $Werewolf.area != 4:
			$Werewolf.area = 4
			$Werewolf.update_area()
	elif $Areas/Area5.overlaps_body($Werewolf):
		if $Werewolf.area != 5:
			$Werewolf.area = 5
			$Werewolf.update_area()
	else: if $Werewolf.area != 0:
		$Werewolf.area = 0
		$Werewolf.update_area()
	pass

func loading():
	$Werewolf.moonlight = $Moonlight
	$Enemies/GenericEnemy.player = $Werewolf
	$Enemies/GenericEnemy2.player = $Werewolf
	$Enemies/GenericEnemy3.player = $Werewolf
	$Enemies/GenericEnemy4.player = $Werewolf
	$Enemies/GenericEnemy5.player = $Werewolf
	$Enemies/GenericEnemy6.player = $Werewolf
	$Enemies/GenericEnemy7.player = $Werewolf
	$Enemies/GenericEnemy8.player = $Werewolf
	$Enemies/GenericEnemy9.player = $Werewolf
	$Enemies/GenericEnemy10.player = $Werewolf
	$Enemies/GenericEnemy11.player = $Werewolf
	$Enemies/GenericEnemy12.player = $Werewolf
	$Enemies/GenericEnemy13.player = $Werewolf
	$Enemies/GenericEnemy14.player = $Werewolf
	$Enemies/GenericEnemy15.player = $Werewolf
	$Enemies/GenericEnemy16.player = $Werewolf
	$Enemies/GenericEnemy17.player = $Werewolf
	$Enemies/GenericEnemy18.player = $Werewolf
	$Enemies/GenericEnemy19.player = $Werewolf
	$Enemies/GenericEnemy20.player = $Werewolf
	$Shepherds/Shepherd1.player = $Werewolf
	$Shepherds/Shepherd2.player = $Werewolf
	$Shepherds/Shepherd3.player = $Werewolf
	$Shepherds/Shepherd4.player = $Werewolf
	$Shepherds/Shepherd5.player = $Werewolf
	$Churches/Church1.player = $Werewolf
	$Churches/Church2.player = $Werewolf
	$Churches/Church3.player = $Werewolf
	$Churches/Church4.player = $Werewolf
	$Churches/Church5.player = $Werewolf
	$Werewolf/AnimationPlayer.play("HumanIdle")
	pass
