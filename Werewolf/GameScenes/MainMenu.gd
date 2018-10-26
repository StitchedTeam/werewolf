extends Node

var initial_buttons_enabled = true

func _ready():
	$ClickCount.connect("timeout", self, "on_click_counted")
	pass

func _process(delta):
	buttons_check()
	pass

func buttons_check():
	
	if $Panel/StartButtons/Play.is_pressed():
		$Panel/NewGameCheck.visible = true
		$Panel/StartButtons.visible = false
		$ClickCount.start()
	
	if $Panel/StartButtons/Options.is_pressed():
		$Panel/StartButtons.visible = false
		$ClickCount.start()
	
	if $Panel/StartButtons/About.is_pressed():
		$Panel/StartButtons.visible = false
		$ClickCount.start()
	
	if Input.is_action_just_pressed("click") && !initial_buttons_enabled && !$Panel/NewGameCheck/NewGame.is_pressed() && !$Panel/NewGameCheck/Continue.is_pressed():
		initial_buttons_enabled = true
		$Panel/NewGameCheck.visible = false
		$Panel/StartButtons.visible = true
	
	
	
	pass

func on_click_counted():
	initial_buttons_enabled = false
	pass