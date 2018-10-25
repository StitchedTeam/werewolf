extends Node2D

var auto_enabled = false

var first_click = false
var timer_drag = false
var drag_enabled = false

var position_dictionary = {"1": 0, "2": 0, "3" : 0, "4": 0, "5": 0, "6": 0, "7": 0, "8": 0}
var dic
var resultant_axis = Dictionary()

func _ready():
	$Timer.connect("timeout", self, "timer_end")
	$TimerDrag.connect("timeout", self, "timer_drag_end")
	pass

func _process(delta):
	enable_auto()
	drag_and_place()
	# To make Input Area's empty collider follow mouse position
	$Input_area.position = get_local_mouse_position()
	pass

func enable_auto():
	if Input.is_action_just_pressed("click") && $Input_area.overlaps_area($Inside_area):
		if first_click:
			if auto_enabled:
				auto_enabled = false
				$Inside_area/Inside_sprite.frame = 0
			elif !auto_enabled:
				auto_enabled = true
				$Inside_area/Inside_sprite.frame = 1
			first_click = false
		else:
			$TimerDrag.start()
			timer_drag = true
	if Input.is_action_just_released("click"):
		drag_enabled = false
		if !auto_enabled:
			$Inside_area.position = $Positions/Origin.position
		if timer_drag:
			first_click = true
			$Timer.start()
	pass

func timer_end():
	first_click = false
	pass

func timer_drag_end():
	timer_drag = false
	if !first_click:
		drag_enabled = true
	pass
	
func drag_and_place():
	
	if !$Inside_area.overlaps_area($Outside_area):
		drag_enabled = false
		if !auto_enabled:
			$Inside_area.position = $Positions/Origin.position
	
	if drag_enabled:
		if $Input_area.overlaps_area($Inside_area):
			$Inside_area.position = $Input_area.position
	
	build_position_dictionary()
	pass

func build_position_dictionary():

	dic = position_dictionary.duplicate()

	dic["1"] = $Inside_area.position.distance_to(($Positions/North).position)
	dic["2"] = $Inside_area.position.distance_to(($Positions/South).position)
	dic["3"] = $Inside_area.position.distance_to(($Positions/East).position)
	dic["4"] = $Inside_area.position.distance_to(($Positions/West).position)
	dic["5"] = $Inside_area.position.distance_to(($Positions/NorthEast).position)
	dic["6"] = $Inside_area.position.distance_to(($Positions/NorthWest).position)
	dic["7"] = $Inside_area.position.distance_to(($Positions/SouthEast).position)
	dic["8"] = $Inside_area.position.distance_to(($Positions/SouthWest).position)
	clean_dic()

	pass

func clean_dic():
	if dic["1"] > dic["2"]:
		dic.erase("1")
	elif dic["1"] < dic["2"]:
		dic.erase("2")
	else:
		dic.erase("1")
		dic.erase("2")

	if dic["3"] > dic["4"]:
		dic.erase("3")
	elif dic["3"] < dic["4"]:
		dic.erase("4")
	else:
		dic.erase("3")
		dic.erase("4")

	if dic["5"] > dic["8"]:
		dic.erase("5")
	elif dic["5"] < dic["8"]:
		dic.erase("8")
	else:
		dic.erase("5")
		dic.erase("8")

	if dic["6"] > dic["7"]:
		dic.erase("6")
	elif dic["6"] < dic["7"]:
		dic.erase("7")
	else:
		dic.erase("6")
		dic.erase("7")

	if dic.has("1"):
		if dic.has("3"):
			if dic["1"] > dic["3"]:
				dic.erase("1")
			elif dic["1"] < dic["3"]:
				dic.erase("3")
			else:
				dic.erase("1")
				dic.erase("3")
		elif dic.has("4"):
			if dic["1"] > dic["4"]:
				dic.erase("1")
			elif dic["1"] < dic["4"]:
				dic.erase("4")
			else:
				dic.erase("1")
				dic.erase("4")
	elif dic.has("2"):
		if dic.has("3"):
			if dic["2"] > dic["3"]:
				dic.erase("2")
			elif dic["2"] < dic["3"]:
				dic.erase("3")
			else:
				dic.erase("2")
				dic.erase("3")
		elif dic.has("4"):
			if dic["2"] > dic["4"]:
				dic.erase("2")
			elif dic["2"] < dic["4"]:
				dic.erase("4")
			else:
				dic.erase("2")
				dic.erase("4")

	if dic.has("5"):
		if dic.has("6"):
			if dic["5"] > dic["6"]:
				dic.erase("5")
			elif dic["5"] < dic["6"]:
				dic.erase("6")
			else:
				dic.erase("5")
				dic.erase("6")
		elif dic.has("7"):
			if dic["5"] > dic["7"]:
				dic.erase("5")
			elif dic["5"] < dic ["7"]:
				dic.erase("7")
			else:
				dic.erase("5")
				dic.erase("7")
	elif dic.has("8"):
		if dic.has("6"):
			if dic["8"] > dic["6"]:
				dic.erase("8")
			elif dic["8"] < dic["6"]:
				dic.erase("6")
			else:
				dic.erase("8")
				dic.erase("6")
		elif dic.has("7"):
			if dic["8"] > dic["7"]:
				dic.erase("8")
			elif dic["8"] < dic ["7"]:
				dic.erase("7")
			else:
				dic.erase("8")
				dic.erase("7")


	if dic.has("1"):
		if dic.has("5"):
			if dic["1"] > dic["5"]:
				dic.erase("1")
			elif dic["1"] < dic["5"]:
				dic.erase("5")
			else:
				dic.erase("1")
				dic.erase("5")
		elif dic.has("8"):
			if dic["1"] > dic["8"]:
				dic.erase("1")
			elif dic["1"] < dic["8"]:
				dic.erase("8")
			else:
				dic.erase("1")
				dic.erase("8")
		elif dic.has("6"):
			if dic["1"] > dic["6"]:
				dic.erase("1")
			elif dic["1"] < dic["6"]:
				dic.erase("6")
			else:
				dic.erase("1")
				dic.erase("6")
		elif dic.has("7"):
			if dic["1"] > dic["7"]:
				dic.erase("1")
			elif dic["1"] < dic["7"]:
				dic.erase("7")
			else:
				dic.erase("1")
				dic.erase("7")
	elif dic.has("2"):
		if dic.has("5"):
			if dic["2"] > dic["5"]:
				dic.erase("2")
			elif dic["2"] < dic["5"]:
				dic.erase("5")
			else:
				dic.erase("2")
				dic.erase("5")
		elif dic.has("8"):
			if dic["2"] > dic["8"]:
				dic.erase("2")
			elif dic["2"] < dic["8"]:
				dic.erase("8")
			else:
				dic.erase("2")
				dic.erase("8")
		elif dic.has("6"):
			if dic["2"] > dic["6"]:
				dic.erase("2")
			elif dic["2"] < dic["6"]:
				dic.erase("6")
			else:
				dic.erase("2")
				dic.erase("6")
		elif dic.has("7"):
			if dic["2"] > dic["7"]:
				dic.erase("2")
			elif dic["2"] < dic["7"]:
				dic.erase("7")
			else:
				dic.erase("2")
				dic.erase("7")
	elif dic.has("3"):
		if dic.has("5"):
			if dic["3"] > dic["5"]:
				dic.erase("3")
			elif dic["3"] < dic["5"]:
				dic.erase("5")
			else:
				dic.erase("3")
				dic.erase("5")
		elif dic.has("8"):
			if dic["3"] > dic["8"]:
				dic.erase("3")
			elif dic["3"] < dic["8"]:
				dic.erase("8")
			else:
				dic.erase("3")
				dic.erase("8")
		elif dic.has("6"):
			if dic["3"] > dic["6"]:
				dic.erase("3")
			elif dic["3"] < dic["6"]:
				dic.erase("6")
			else:
				dic.erase("3")
				dic.erase("6")
		elif dic.has("7"):
			if dic["3"] > dic["7"]:
				dic.erase("3")
			elif dic["3"] < dic["7"]:
				dic.erase("7")
			else:
				dic.erase("3")
				dic.erase("7")
	elif dic.has("4"):
		if dic.has("5"):
			if dic["4"] > dic["5"]:
				dic.erase("4")
			elif dic["4"] < dic["5"]:
				dic.erase("5")
			else:
				dic.erase("4")
				dic.erase("5")
		elif dic.has("8"):
			if dic["4"] > dic["8"]:
				dic.erase("w")
			elif dic["4"] < dic["8"]:
				dic.erase("8")
			else:
				dic.erase("4")
				dic.erase("8")
		elif dic.has("6"):
			if dic["4"] > dic["6"]:
				dic.erase("4")
			elif dic["4"] < dic["6"]:
				dic.erase("6")
			else:
				dic.erase("4")
				dic.erase("6")
		elif dic.has("7"):
			if dic["4"] > dic["7"]:
				dic.erase("4")
			elif dic["4"] < dic["7"]:
				dic.erase("7")
			else:
				dic.erase("4")
				dic.erase("7")
				
	go_to_nearest()
	pass

func go_to_nearest():
	if dic.has("1"):
		if auto_enabled && !drag_enabled: $Inside_area.position = $Positions/North.position
		resultant_axis.clear()
		resultant_axis = dic.duplicate()
	elif dic.has("2"):
		if auto_enabled && !drag_enabled: $Inside_area.position = $Positions/South.position
		resultant_axis.clear()
		resultant_axis = dic.duplicate()
	elif dic.has("3"):
		if auto_enabled && !drag_enabled: $Inside_area.position = $Positions/East.position
		resultant_axis.clear()
		resultant_axis = dic.duplicate()
	elif dic.has("4"):
		if auto_enabled && !drag_enabled: $Inside_area.position = $Positions/West.position
		resultant_axis.clear()
		resultant_axis = dic.duplicate()
	elif dic.has("5"):
		if auto_enabled && !drag_enabled: $Inside_area.position = $Positions/NorthEast.position
		resultant_axis.clear()
		resultant_axis = dic.duplicate()
	elif dic.has("6"):
		if auto_enabled && !drag_enabled: $Inside_area.position = $Positions/NorthWest.position
		resultant_axis.clear()
		resultant_axis = dic.duplicate()
	elif dic.has("7"):
		if auto_enabled && !drag_enabled: $Inside_area.position = $Positions/SouthEast.position
		resultant_axis.clear()
		resultant_axis = dic.duplicate()
	elif dic.has("8"):
		if auto_enabled && !drag_enabled: $Inside_area.position = $Positions/SouthWest.position
		resultant_axis.clear()
		resultant_axis = dic.duplicate()
	else:
		if auto_enabled && !drag_enabled: $Inside_area.position = $Positions/Origin.position
		resultant_axis.clear()
		resultant_axis = dic.duplicate()
	dic.clear()
	pass