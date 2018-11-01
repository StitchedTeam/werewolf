extends Node2D

var start_pos
var min_x
var max_x

var dir_x = 1
var dir_y = -1
var anim = 0
var dir_y_setted = false

var state = 0
var player
var turn_around_enabled = true
var vertical_move_enabled = false

export var patrol_offset = int()
export var character_spritesheet = int()

func _ready():
	start_pos = position
	max_x = start_pos.x + patrol_offset
	min_x = start_pos.x - patrol_offset
	$Timer.connect("timeout", self, "turn_around_timer")
	$ScaredParticles.set_one_shot(true)
	load_spritesheet()
	pass

func _process(delta):
	manage_animation()
	manage_state()
	pass

func manage_animation():
	if dir_x == 1:
		if anim != 1:
			$AnimationPlayer.play("Right")
			anim = 1
	elif dir_x == -1:
		if anim != -1:
			$AnimationPlayer.play("Left")
			anim = -1
	pass

func load_spritesheet():
	if character_spritesheet == 0:
		$Sprite.texture = load("res://Assets/Sprites/Characters/Enemy1.png")
	elif character_spritesheet == 1:
		$Sprite.texture = load("res://Assets/Sprites/Characters/Enemy2.png")
	pass

func manage_state():
	if state == 0:
		patrol()
	elif state == 1:
		run()
	pass

func patrol():
	
	if dir_x == 1:
		if position.x < max_x:
			position.x += 0.2
		elif position.x >= max_x:
			dir_x = -1
	elif dir_x == -1:
		if position.x > min_x:
			position.x -= 0.2
		elif position.x <= min_x:
			dir_x = 1
	
	if $RayCast2DCollUp.is_colliding():
		if turn_around_enabled:
			if dir_x == 1:
				dir_x = -1
				turn_around_enabled = false
				$Timer.start()
			elif dir_x == -1:
				dir_x = 1
				turn_around_enabled = false
				$Timer.start()
	
	if $RayCast2DCollDown.is_colliding():
		if turn_around_enabled:
			if dir_x == 1:
				dir_x = -1
				turn_around_enabled = false
				$Timer.start()
			elif dir_x == -1:
				dir_x = 1
				turn_around_enabled = false
				$Timer.start()
	
	if $RayCast2DSight.get_collider() == player:
		if player.human == false:
			state = 1
			$ScaredParticles.set_emitting(true)
			$ScaredParticles.restart()
	pass

func turn_around_timer():
	turn_around_enabled = true
	pass

func run():
	
	$RayCast2DRunUp.set_enabled(true)
	$RayCast2DRunDown.set_enabled(true)
	
	if player.position.x > position.x:
		dir_x = -1
	elif player.position.x < position.x:
		dir_x = 1
	
	if !vertical_move_enabled:
		if dir_x == 1:
			position.x += 0.2
		elif dir_x == -1:
			position.x -= 0.2
	elif vertical_move_enabled:
		if !dir_y_setted:
			dir_y = pow(-1, int(rand_range(0, 3)))
		else:
			if dir_y == 1:
				position.y += 0.2
			elif dir_y == -1:
				position.y -= 0.2
	
	
	if $RayCast2DCollUp.is_colliding():
		vertical_move_enabled = true
	
	if $RayCast2DCollDown.is_colliding():
		vertical_move_enabled = true
	
	if !$RayCast2DCollUp.is_colliding() && !$RayCast2DCollDown.is_colliding():
		vertical_move_enabled = false
	
	pass






