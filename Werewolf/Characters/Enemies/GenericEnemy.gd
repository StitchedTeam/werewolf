extends KinematicBody2D

var start_pos
var dir = 1
var anim = 0

func _ready():
	start_pos = position
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
	
func patrol():
	
	pass