extends Node

var save = "user://save_game.dat"
var file = File.new()

const PRIEST_ALIVE = {"1": true}
const CHURCH_EXISTS = {"1": true}
const LIFE = 0

var priest_alive = {"1": true}
var church_exists = {"1": true}
var life = 0

func save(content):
	file.open("user://save_game.dat", File.WRITE)
	file.store_var(content)
	file.close()
	pass

func check_save():
	file.open("user://save_game.dat", File.READ)
	var content = file.get_var()
	file.close()
	if (content.priest_alive == PRIEST_ALIVE) && (content.church_exists == CHURCH_EXISTS) && (content.life == LIFE):
		return false
	else:
		return true
	pass

func load_game():
	file.open("user://save_game.dat", File.READ)
	var content = file.get_var()
	priest_alive = content.priest_alive
	church_exists = content.church_exists
	life = content.life
	file.close()
	pass

func reset_save():
	var save_dic = {
		"priest_alive": PRIEST_ALIVE,
		"church_exist": CHURCH_EXISTS,
		"life": LIFE
		}
	
	save(save_dic)
	pass