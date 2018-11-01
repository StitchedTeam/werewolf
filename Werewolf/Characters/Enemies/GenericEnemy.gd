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

func _ready():
	start_pos = position
	max_x = start_pos.x + patrol_offset
	min_x = start_pos.x - patrol_offset
	$Timer.connect("timeout", self, "turn_around_timer")
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
		state = 1
	pass

func turn_around_timer():
	turn_around_enabled = true
	pass

func run():
	pass