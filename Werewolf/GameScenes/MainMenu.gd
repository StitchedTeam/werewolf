extends Node

var initial_buttons_enabled = true

func _ready():
	GameGlobals.load_game()
	$ClickCount.connect("timeout", self, "on_click_counted")
	pass

func _process(delta):
	buttons_check()
	pass

func buttons_check():
	
	if $Panel/StartButtons/Play.is_pressed():
		if GameGlobals.saved:
			$Panel/NewGameCheck.visible = true
			$Panel/StartButtons.visible = false
			$ClickCount.start()
		else:
			start_game()
		
	if $Panel/StartButtons/Options.is_pressed():
		$Panel/StartButtons.visible = false
		$Panel/Options.visible = true
		$Panel/Back.visible = true
	
	if $Panel/StartButtons/About.is_pressed():
		$Panel/StartButtons.visible = false
		$Panel/Back.visible = true
	
	if $Panel/Back.is_pressed():
		$Panel/StartButtons.visible = true
		$Panel/Options.visible = false
		$Panel/About.visible = false
		$Panel/Back.visible = false
	
	if $Panel/NewGameCheck/NewGame.is_pressed():
		start_game()
	
	if $Panel/NewGameCheck/Continue.is_pressed():
		load_game()
	
	if Input.is_action_just_pressed("click") && !initial_buttons_enabled && !$Panel/NewGameCheck/NewGame.is_pressed() && !$Panel/NewGameCheck/Continue.is_pressed():
		initial_buttons_enabled = true
		$Panel/NewGameCheck.visible = false
		$Panel/StartButtons.visible = true
	
	
	pass

func on_click_counted():
	initial_buttons_enabled = false
	pass

func start_game():
	GameGlobals.reset_save()
	get_tree().change_scene("res://Sandbox/Sandbox.tscn")
	pass

func load_game():
	GameGlobals.load_game()
	get_tree().change_scene("res://Sandbox/Sandbox.tscn")
	pass