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
export var run_state_offset = int()

var death_started = false

export var area = int()

func _ready():
	loading()
	pass

func _process(delta):
	
	manage_animation()
	manage_state()
	damage()
	
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
			dir_y_setted = true
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
	
	if position.distance_to(player.position) >= run_state_offset:
		state = 0
	pass

func damage():
	if player.enemy == $StaticBody2D.get_instance_id():
		if !GameGlobals.priest_alive.has(String(area)):
			if !death_started:
				$DeathParticles.set_emitting(true)
				$DeathTimer.start()
				death_started = true
	pass

func death_animation_end():
	GameGlobals.life += 10
	GameGlobals.enemies_alive[String(area)] -= 1
	player.update_area()
	get_tree().queue_delete(self)
	pass

func loading():
	start_pos = position
	max_x = start_pos.x + patrol_offset
	min_x = start_pos.x - patrol_offset
	$Timer.connect("timeout", self, "turn_around_timer")
	$DeathTimer.connect("timeout", self, "death_animation_end")
	$ScaredParticles.set_one_shot(true)
	load_spritesheet()
	pass

func load_spritesheet():
	if character_spritesheet == 0:
		$Sprite.texture = load("res://Assets/Sprites/Characters/Enemy1.png")
	elif character_spritesheet == 1:
		$Sprite.texture = load("res://Assets/Sprites/Characters/Enemy2.png")
	elif character_spritesheet == 2:
		$Sprite.texture = load("res://Assets/Sprites/Characters/Enemy_00.png")
	elif character_spritesheet == 3:
		$Sprite.texture = load("res://Assets/Sprites/Characters/Enemy_01.png")
	elif character_spritesheet == 4:
		$Sprite.texture = load("res://Assets/Sprites/Characters/Enemy_02.png")
	elif character_spritesheet == 5:
		$Sprite.texture = load("res://Assets/Sprites/Characters/Enemy_03.png")
	elif character_spritesheet == 6:
		$Sprite.texture = load("res://Assets/Sprites/Characters/Enemy_04.png")
	elif character_spritesheet == 7:
		$Sprite.texture = load("res://Assets/Sprites/Characters/Enemy_05.png")
	elif character_spritesheet == 8:
		$Sprite.texture = load("res://Assets/Sprites/Characters/Enemy_06.png")
	elif character_spritesheet == 9:
		$Sprite.texture = load("res://Assets/Sprites/Characters/Enemy_07.png")
	elif character_spritesheet == 10:
		$Sprite.texture = load("res://Assets/Sprites/Characters/Enemy_08.png")
	elif character_spritesheet == 11:
		$Sprite.texture = load("res://Assets/Sprites/Characters/Enemy_09.png")
	elif character_spritesheet == 12:
		$Sprite.texture = load("res://Assets/Sprites/Characters/Enemy_10.png")
	elif character_spritesheet == 13:
		$Sprite.texture = load("res://Assets/Sprites/Characters/Enemy_11.png")
	elif character_spritesheet == 14:
		$Sprite.texture = load("res://Assets/Sprites/Characters/Enemy_12.png")
	elif character_spritesheet == 15:
		$Sprite.texture = load("res://Assets/Sprites/Characters/Enemy_13.png")
	elif character_spritesheet == 16:
		$Sprite.texture = load("res://Assets/Sprites/Characters/Enemy_14.png")
	elif character_spritesheet == 17:
		$Sprite.texture = load("res://Assets/Sprites/Characters/Enemy_15.png")
	elif character_spritesheet == 18:
		$Sprite.texture = load("res://Assets/Sprites/Characters/Enemy_16.png")
	pass