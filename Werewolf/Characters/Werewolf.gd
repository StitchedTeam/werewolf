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
	find_direction_axis()
	
	pass

func manage_animation():
	if human:
		if horax == 1:
			$AnimationPlayer.play("HumanRight")
		elif horax == -1:
			$AnimationPlayer.play("HumanLeft")
		elif vertax == 1:
			$AnimationPlayer.play("HumanDown")
		elif vertax == -1:
			$AnimationPlayer.play("HumanUp")
		else:
			$AnimationPlayer.play("HumanIdle")
	else:
		if horax == 1:
			$AnimationPlayer.play("WolfRight")
		elif horax == -1:
			$AnimationPlayer.play("WolfLeft")
		else:
			$AnimationPlayer.play("WolfIdle")
	pass

func switch_human():
	if human:
		human = false
		manage_animation()
		$HumanCollider.disabled = true
		$WolfCollider.disabled = false
	else:
		human = true
		manage_animation()
		$HumanCollider.disabled = false
		$WolfCollider.disabled = true
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

func find_direction_axis():
	if $Camera2D/UI/PlayerControl.resultant_axis.has("1"):
		set_axis(1)
	elif $Camera2D/UI/PlayerControl.resultant_axis.has("2"):
		set_axis(2)
	elif $Camera2D/UI/PlayerControl.resultant_axis.has("3"):
		set_axis(3)
	elif $Camera2D/UI/PlayerControl.resultant_axis.has("4"):
		set_axis(4)
	elif $Camera2D/UI/PlayerControl.resultant_axis.has("5"):
		set_axis(5)
	elif $Camera2D/UI/PlayerControl.resultant_axis.has("6"):
		set_axis(6)
	elif $Camera2D/UI/PlayerControl.resultant_axis.has("7"):
		set_axis(7)
	elif $Camera2D/UI/PlayerControl.resultant_axis.has("8"):
		set_axis(8)
	else:
		set_axis(0)
	
	if $Camera2D/UI/PlayerControl.auto_enabled:
		speed = 5
	else:
		speed = 20
	pass

















