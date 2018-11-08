extends Node


func _ready():
	pass

func _process(delta):
	if GameGlobals.life > 100:
		GameGlobals.life = 100
	pause()
	game_over()
	pass

func pause():
	if $CanvasLayer/UI/PauseButton.pressed:
		get_tree().paused = true
		$CanvasLayer/UI/PauseScreen.set_visible(true)
		$CanvasLayer/UI/PauseButton.set_visible(false)
	if $CanvasLayer/UI/PauseScreen/ResumeButton.pressed:
		$CanvasLayer/UI/PauseScreen.set_visible(false)
		$CanvasLayer/UI/PauseButton.set_visible(true)
		get_tree().paused = false
	if $CanvasLayer/UI/PauseScreen/OptionsButton.pressed:
		$CanvasLayer/UI/PauseScreen/ResumeButton.set_visible(false)
		$CanvasLayer/UI/PauseScreen/OptionsButton.set_visible(false)
		$CanvasLayer/UI/PauseScreen/MainMenuButton.set_visible(false)
		$CanvasLayer/UI/PauseScreen/OptionsScreen.set_visible(true)
	if $CanvasLayer/UI/PauseScreen/OptionsScreen/Back.pressed:
		$CanvasLayer/UI/PauseScreen/ResumeButton.set_visible(true)
		$CanvasLayer/UI/PauseScreen/OptionsButton.set_visible(true)
		$CanvasLayer/UI/PauseScreen/MainMenuButton.set_visible(true)
		$CanvasLayer/UI/PauseScreen/OptionsScreen.set_visible(false)
	if $CanvasLayer/UI/PauseScreen/MainMenuButton.pressed:
		$CanvasLayer/UI/PauseScreen/ResumeButton.set_visible(false)
		$CanvasLayer/UI/PauseScreen/OptionsButton.set_visible(false)
		$CanvasLayer/UI/PauseScreen/MainMenuButton.set_visible(false)
		$CanvasLayer/UI/PauseScreen/MainMenuScreen.set_visible(true)
	if $CanvasLayer/UI/PauseScreen/MainMenuScreen/NoButton.pressed:
		$CanvasLayer/UI/PauseScreen/ResumeButton.set_visible(true)
		$CanvasLayer/UI/PauseScreen/OptionsButton.set_visible(true)
		$CanvasLayer/UI/PauseScreen/MainMenuButton.set_visible(true)
		$CanvasLayer/UI/PauseScreen/MainMenuScreen.set_visible(false)
	if $CanvasLayer/UI/PauseScreen/MainMenuScreen/YesButton.pressed:
		get_tree().paused = false
		get_tree().change_scene("res://GameScenes/MainMenu.tscn")
	pass

func game_over():
	if $Sandbox/Werewolf.game_over:
		get_tree().paused = true
		$CanvasLayer/UI/GameOverScreen.set_visible(true)
	if $CanvasLayer/UI/GameOverScreen/MainMenuButton.pressed:
		get_tree().paused = false
		get_tree().change_scene("res://GameScenes/MainMenu.tscn")
	pass