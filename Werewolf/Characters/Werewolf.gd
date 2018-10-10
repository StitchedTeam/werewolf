extends KinematicBody2D

var human = true
var horax = 0
var vertax = 0

var speed = 1

func _ready():
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