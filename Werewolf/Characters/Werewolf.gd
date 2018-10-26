extends KinematicBody2D

var human = true

var horax = 0
var vertax = 0

var axis = 0

var speed = 5

func _ready():
	$WolfCollider.disabled = true
	pass

func _physics_process(delta):
	
	move_and_slide(Vector2 (speed * horax, speed * vertax))
	
	pass

func manage_animation():
	if human:
		if horax == 1:
			$AnimationPlayer.play("HumanRight")
		elif horax == -1:
			$AnimationPlayer.play("HumanLeft")
		else:
			$AnimationPlayer.play("HumanIdle")
	
	pass

func switch_human():
	if human:
		print("Switching to wolf")
	else:
		print("Switching to human")
	pass

func set_axis(var new_axis):
	if new_axis != axis:
		if new_axis == 1:
			axis = 1
			horax = 0
			vertax = -1
			manage_animation()
		elif new_axis == 2:
			axis = 2
			horax = 0
			vertax = 1
			manage_animation()
		elif new_axis == 3:
			axis = 3
			horax = 1
			vertax = 0
			manage_animation()
		elif new_axis == 4:
			axis = 4
			horax = -1
			vertax = 0
			manage_animation()
		elif new_axis == 5:
			axis = 5
			horax = 1
			vertax = -1
			manage_animation()
		elif new_axis == 6:
			axis = 6
			horax = -1
			vertax = -1
			manage_animation()
		elif new_axis == 7:
			axis = 7
			horax = 1
			vertax = 1
			manage_animation()
		elif new_axis == 8:
			axis = 8
			horax = -1
			vertax = 1
			manage_animation()
		else:
			axis = 0
			horax = 0
			vertax = 0
			manage_animation()
		
	pass


















