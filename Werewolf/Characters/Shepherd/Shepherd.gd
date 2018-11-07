extends Node2D

var state = 0

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

func _ready():
	start_pos = position
	max_patrol = Vector2(start_pos.x + patrol_offset, start_pos.y + patrol_offset)
	min_patrol = Vector2(start_pos.x - patrol_offset, start_pos.y - patrol_offset)
	pass

func _process(delta):
	manage_state()
	pass

func manage_state():
	
	if state == 0:
		patrol()
	
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
	
	
	pass

func change_patrol_dir():
	print("change patrol dir")
	dir_changing = true
	
	if dir == 0:
		zero.shuffle()
		dir = zero.front()
		dir_changing = false
	elif dir == 1:
		one.shuffle()
		dir = one.front()
		dir_changing = false
	elif dir == 2:
		two.shuffle()
		dir = two.front()
		dir_changing = false
	elif dir == 3:
		three.shuffle()
		dir = three.front()
		dir_changing = false
	
	pass














