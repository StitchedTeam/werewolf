extends Node2D

var start_pos
var min_x
var max_x

var dir = 1
var anim = 0

var state = 0
var player
var turn_around_enabled = true

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
	if dir == 1:
		if anim != 1:
			$AnimationPlayer.play("Right")
			anim = 1
	elif dir == -1:
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
	
	if dir == 1:
		if position.x < max_x:
			position.x += 0.2
		elif position.x >= max_x:
			dir = -1
	elif dir == -1:
		if position.x > min_x:
			position.x -= 0.2
		elif position.x <= min_x:
			dir = 1
	
	if $RayCast2DCollUp.is_colliding():
		if turn_around_enabled:
			if dir == 1:
				dir = -1
				turn_around_enabled = false
				$Timer.start()
			elif dir == -1:
				dir = 1
				turn_around_enabled = false
				$Timer.start()
	
	if $RayCast2DCollDown.is_colliding():
		if turn_around_enabled:
			if dir == 1:
				dir = -1
				turn_around_enabled = false
				$Timer.start()
			elif dir == -1:
				dir = 1
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
	if player.position.x > position.x:
		dir = -1
	elif player.position.x < position.x:
		dir = 1
	
	if dir == 1:
			position.x += 0.2
	elif dir == -1:
		position.x -= 0.2
	pass