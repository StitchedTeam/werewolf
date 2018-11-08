extends Node

var save = "user://save_game.dat"
var file = File.new()

const PRIEST_ALIVE = {"1": true}
const CHURCH_EXISTS = {"1": true}
const LIFE = 100

var priest_alive = {"1": true}
var church_exists = {"1": true}
var life = 100

var saved = false

var player

func save(content):
	saved = true
	file.open("user://save_game.dat", File.WRITE)
	file.store_var(content)
	file.close()
	pass

func load_game():
	file.open("user://save_game.dat", File.READ)
	var content = file.get_var()
	file.close()
	if content != null:
		priest_alive = content.priest_alive
		church_exists = content.church_exists
		life = content.life
		saved = content.saved
	pass

func reset_save():
	var save_dic = {
		"priest_alive": PRIEST_ALIVE,
		"church_exists": CHURCH_EXISTS,
		"life": LIFE,
		"saved": false
		}
	save(save_dic)
	saved = false
	pass

func build_save():
	var save_dic = {
		"priest_alive": priest_alive,
		"church_exists": church_exists,
		"life": life,
		"saved" : true
		}
	return save_dic
	pass