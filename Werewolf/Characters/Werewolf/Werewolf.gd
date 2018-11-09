extends KinematicBody2D

var human = true

var enemy

var horax = 0
var vertax = 0

var axis = 0

var speed = 5

var attacking = false
var transforming = false

var life = GameGlobals.life
var life_changing = false

var game_over = false
var moonlight

func _ready():
	$AttackTimer.connect("timeout", self, "on_attack_end")
	$TransformTimer.connect("timeout", self, "on_transform_end")
	$LifeTimer.connect("timeout", self, "on_life_timeout")
	pass

func _physics_process(delta):
	
	move_and_slide(Vector2 (speed * horax, speed * vertax))
	find_direction_axis()
	wolf_life()
	death()
	if Input.is_action_just_pressed("fire"):
		attack()
		manage_animation()
	
	pass

func wolf_life():
	if !human:
		if !life_changing:
			life_changing = true
			$LifeTimer.start()
			$Camera2D/UI/HUD/ProgressBar.value = life
	else:
		$LifeTimer.stop()
	pass

func manage_animation():
	if !transforming:
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
			if !attacking:
				if horax == 1:
					$AnimationPlayer.play("WolfRight")
				elif horax == -1:
					$AnimationPlayer.play("WolfLeft")
				elif vertax == 1:
					$AnimationPlayer.play("WolfDown")
				elif vertax == -1:
					$AnimationPlayer.play("WolfUp")
				else:
					$AnimationPlayer.play("WolfIdle")
			elif attacking:
				if horax == 1:
					$AnimationPlayer.play("AttackRight")
				elif horax == -1:
					$AnimationPlayer.play("AttackLeft")
				elif vertax == 1:
					$AnimationPlayer.play("AttackDown")
				elif vertax == -1:
					$AnimationPlayer.play("AttackUp")
	pass

func switch_human():
	transforming = true
	moonlight.transforming()
	$AnimationPlayer.play("Transform")
	$TransformTimer.start()
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

func attack():
	if !human:
		attacking = true
		$AttackTimer.start()
	pass

func on_attack_end():
	attacking = false
	manage_animation()
	if $RayCast2D.get_collider() != null:
			enemy = $RayCast2D.get_collider().get_instance_id()
			print(enemy)
	pass

func on_transform_end():
	transforming = false
	if human:
		human = false
		$Camera2D/UI/HUD.set_visible(true)
		manage_animation()
	else:
		moonlight.detect_enabled = true
		human = true
		$Camera2D/UI/HUD.set_visible(false)
		manage_animation()
	pass

func on_life_timeout():
	GameGlobals.life -= 1
	life = GameGlobals.life
	life_changing = false
	pass

func death():
	if life <= 0:
		game_over = true
		GameGlobals.reset_save()
	pass







