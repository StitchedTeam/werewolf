extends Node


func _ready():
	$CanvasLayer/UI/PauseScreen/OptionsScreen/MusicVolume.value = GameGlobals.music_volume
	$CanvasLayer/UI/PauseScreen/OptionsScreen/SFXVolume.value = GameGlobals.sfx_volume
	pass

func _process(delta):
	if GameGlobals.life > 100:
		GameGlobals.life = 100
	pause()
	game_over()
	audio()
	options()
	pass

func pause():
	if $CanvasLayer/UI/PauseButton.pressed:
		$Click.play()
		$GameMusic.stop()
		$PauseMusic.play()
		get_tree().paused = true
		$CanvasLayer/UI/PauseScreen.set_visible(true)
		$CanvasLayer/UI/PauseButton.set_visible(false)
	if $CanvasLayer/UI/PauseScreen/ResumeButton.pressed:
		$Click.play()
		$GameMusic.play()
		$PauseMusic.stop()
		$CanvasLayer/UI/PauseScreen.set_visible(false)
		$CanvasLayer/UI/PauseButton.set_visible(true)
		get_tree().paused = false
	if $CanvasLayer/UI/PauseScreen/OptionsButton.pressed:
		$Click.play()
		$CanvasLayer/UI/PauseScreen/ResumeButton.set_visible(false)
		$CanvasLayer/UI/PauseScreen/OptionsButton.set_visible(false)
		$CanvasLayer/UI/PauseScreen/MainMenuButton.set_visible(false)
		$CanvasLayer/UI/PauseScreen/OptionsScreen.set_visible(true)
	if $CanvasLayer/UI/PauseScreen/OptionsScreen/Back.pressed:
		$Click.play()
		$CanvasLayer/UI/PauseScreen/ResumeButton.set_visible(true)
		$CanvasLayer/UI/PauseScreen/OptionsButton.set_visible(true)
		$CanvasLayer/UI/PauseScreen/MainMenuButton.set_visible(true)
		$CanvasLayer/UI/PauseScreen/OptionsScreen.set_visible(false)
	if $CanvasLayer/UI/PauseScreen/MainMenuButton.pressed:
		$Click.play()
		$CanvasLayer/UI/PauseScreen/ResumeButton.set_visible(false)
		$CanvasLayer/UI/PauseScreen/OptionsButton.set_visible(false)
		$CanvasLayer/UI/PauseScreen/MainMenuButton.set_visible(false)
		$CanvasLayer/UI/PauseScreen/MainMenuScreen.set_visible(true)
	if $CanvasLayer/UI/PauseScreen/MainMenuScreen/NoButton.pressed:
		$Click.play()
		$CanvasLayer/UI/PauseScreen/ResumeButton.set_visible(true)
		$CanvasLayer/UI/PauseScreen/OptionsButton.set_visible(true)
		$CanvasLayer/UI/PauseScreen/MainMenuButton.set_visible(true)
		$CanvasLayer/UI/PauseScreen/MainMenuScreen.set_visible(false)
	if $CanvasLayer/UI/PauseScreen/MainMenuScreen/YesButton.pressed:
		$Click.play()
		get_tree().paused = false
		get_tree().change_scene("res://GameScenes/MainMenu.tscn")
	pass

func audio():
	
	if $GameMusic.volume_db != GameGlobals.music_volume:
		$GameMusic.volume_db = GameGlobals.music_volume
	if $PauseMusic.volume_db != GameGlobals.music_volume - 30:
		$PauseMusic.volume_db = GameGlobals.music_volume - 30
	if $Click.volume_db != GameGlobals.sfx_volume:
		$Click.volume_db = GameGlobals.sfx_volume
	pass

func options():
	GameGlobals.sfx_volume = $CanvasLayer/UI/PauseScreen/OptionsScreen/SFXVolume.value
	GameGlobals.music_volume = $CanvasLayer/UI/PauseScreen/OptionsScreen/MusicVolume.value
	pass

func game_over():
	if $Sandbox/Werewolf.game_over:
		get_tree().paused = true
		$CanvasLayer/UI/GameOverScreen.set_visible(true)
	if $CanvasLayer/UI/GameOverScreen/MainMenuButton.pressed:
		get_tree().paused = false
		get_tree().change_scene("res://GameScenes/MainMenu.tscn")
	pass