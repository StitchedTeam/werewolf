extends Node2D

var dir = 0
var dir_changing = false

var start_pos = Vector2()
var max_patrol
var min_patrol

export var patrol_offset = int()

export var speed = float()

var zero = [1, 2, 3]
var one = [0, 2, 3]
var two = [0, 1, 3]
var three = [0, 1, 2]

var player
var death_started = false

export var area = int()

func _ready():
	loading()
	pass

func _process(delta):
	patrol()
	damage()
	pass

func manage_animation():
	if dir == 0:
		$AnimationPlayer.play("Right")
	elif dir == 1:
		$AnimationPlayer.play("Left")
	elif dir == 2:
		$AnimationPlayer.play("Up")
	elif dir == 3:
		$AnimationPlayer.play("Down")
	pass

func patrol():
	
	if dir == 0: #direita
		if position.x < max_patrol.x:
			position.x += speed
		elif !dir_changing:
			change_patrol_dir()
	elif dir == 1: #esquerda
		if position.x > min_patrol.x:
			position.x -= speed
		elif !dir_changing:
			change_patrol_dir()
	elif dir == 2: #cima
		if position.y < max_patrol.y:
			position.y += speed
		elif !dir_changing:
			change_patrol_dir()
	elif dir == 3: #baixo
		if position.y > min_patrol.y:
			position.y -= speed
		elif !dir_changing:
			change_patrol_dir()
	
	if $RayCast2D.is_colliding():
		if !dir_changing:
			change_patrol_dir()
	if $RayCast2D2.is_colliding():
		if !dir_changing:
			change_patrol_dir()
	
	pass

func change_patrol_dir():
	dir_changing = true
	$DirChangeTimer.start()
	
	if dir == 0:
		zero.shuffle()
		dir = zero.front()
		manage_animation()
	elif dir == 1:
		one.shuffle()
		dir = one.front()
		manage_animation()
	elif dir == 2:
		two.shuffle()
		dir = two.front()
		manage_animation()
	elif dir == 3:
		three.shuffle()
		dir = three.front()
		manage_animation()
	pass

func dir_change_timeout():
	dir_changing = false
	pass

func damage():
	if player.enemy == $StaticBody2D.get_instance_id():
		if !death_started:
			$DeathParticles.set_emitting(true)
			death_started = true
			$DeathTimer.start()
	pass

func death_animation_end():
	GameGlobals.priest_alive.erase(String(area))
	GameGlobals.save(GameGlobals.build_save())
	GameGlobals.life += 20
	remove()
	pass

func remove():
	get_tree().queue_delete(self)
	pass

func loading():
	if !GameGlobals.priest_alive.has(String(area)):
		remove()
	start_pos = position
	max_patrol = Vector2(start_pos.x + patrol_offset, start_pos.y + patrol_offset)
	min_patrol = Vector2(start_pos.x - patrol_offset, start_pos.y - patrol_offset)
	$AnimationPlayer.play("Right")
	$DirChangeTimer.connect("timeout", self, "dir_change_timeout")
	$DeathTimer.connect("timeout", self, "death_animation_end")
	pass
