extends KinematicBody2D

var start_pos
var min_x
var max_x

var dir = 1
var anim = 0

export var patrol_offset = int()

func _ready():
	start_pos = position
	max_x = start_pos.x + patrol_offset
	min_x = start_pos.x - patrol_offset
	pass

func _process(delta):
	manage_animation()
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

func patrol(player):
	
	if dir == 1:
		if position.x < max_x:
			move_and_slide(Vector2(0.1, 0))
		elif position.x >= max_x:
			dir = -1
		elif get_slide_collision(0) != null:
			dir = -1
	elif dir == -1:
		if position.x > min_x:
			move_and_slide(Vector2(-0.1, 0))
		elif position.x <= min_x:
			dir = 1
		elif get_slide_collision(0) != null:
			dir = 1
	
	if $RayCast2DLeft.get_collider() == player && player.human == false:
		run(player)
	elif $RayCast2DRight.get_collider() == player && player.human == false:
		run(player)
	else:
		patrol(player)
	
	pass

func run(player):
	pass