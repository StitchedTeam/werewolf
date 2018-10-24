extends Node2D

var auto_enabled = false

var dragging = false
var drag_ended = false

var position_dictionary = {"N": 0, "S": 0, "E" : 0, "W": 0, "NE": 0, "NW": 0, "SE": 0, "SW": 0}
var dic
var resultant_axis = Dictionary()

func _ready():
	pass

func _process(delta):
	drag_and_place()
	# To make Input Area's empty collider follow mouse position
	$Input_area.position = get_local_mouse_position()
	pass

func drag_and_place():
	
	# To check if drag has started or ended
	if (!dragging && Input.is_action_pressed("click") && $Input_area.overlaps_area($Inside_area)):
		print("Controller drag started")
		dragging = true
	
	if dragging:
		if (Input.is_action_just_released("click")||!($Input_area.overlaps_area($Inside_area))):
			print("Controller drag ended")
			dragging = false
			drag_ended = true
		if ($Input_area.overlaps_area($Outside_area) && !drag_ended):
			$Inside_area.position = $Input_area.position
	
	# To bring control to the correct position after drag ended
	if auto_enabled:
		if drag_ended:
			if !($Inside_area.overlaps_area($Center_area)):
				build_position_dictionary()
			else:
				$Inside_area.position = $Positions/Origin.position
				resultant_axis.clear()
				drag_ended = false
	else:
		if drag_ended:
			resultant_axis.clear()
			$Inside_area.position = $Positions/Origin.position
		build_position_dictionary()
	pass
	
# Brings between the control and all eight positions to the dictionary
func build_position_dictionary():
	
	dic = position_dictionary.duplicate()
	
	dic["N"] = $Inside_area.position.distance_to(($Positions/North).position)
	dic["S"] = $Inside_area.position.distance_to(($Positions/South).position)
	dic["E"] = $Inside_area.position.distance_to(($Positions/East).position)
	dic["W"] = $Inside_area.position.distance_to(($Positions/West).position)
	dic["NE"] = $Inside_area.position.distance_to(($Positions/NorthEast).position)
	dic["NW"] = $Inside_area.position.distance_to(($Positions/NorthWest).position)
	dic["SE"] = $Inside_area.position.distance_to(($Positions/SouthEast).position)
	dic["SW"] = $Inside_area.position.distance_to(($Positions/SouthWest).position)
	
	clean_dic()
	
	pass

func clean_dic():
	if dic["N"] > dic["S"]:
		dic.erase("N")
	elif dic["N"] < dic["S"]:
		dic.erase("S")
	else:
		dic.erase("N")
		dic.erase("S")
	
	if dic["E"] > dic["W"]:
		dic.erase("E")
	elif dic["E"] < dic["W"]:
		dic.erase("W")
	else:
		dic.erase("E")
		dic.erase("W")
	
	if dic["NE"] > dic["SW"]:
		dic.erase("NE")
	elif dic["NE"] < dic["SW"]:
		dic.erase("SW")
	else:
		dic.erase("NE")
		dic.erase("SW")
	
	if dic["NW"] > dic["SE"]:
		dic.erase("NW")
	elif dic["NW"] < dic["SE"]:
		dic.erase("SE")
	else:
		dic.erase("NW")
		dic.erase("SE")
	
	if dic.has("N"):
		if dic.has("E"):
			if dic["N"] > dic["E"]:
				dic.erase("N")
			elif dic["N"] < dic["E"]:
				dic.erase("E")
			else:
				dic.erase("N")
				dic.erase("E")
		elif dic.has("W"):
			if dic["N"] > dic["W"]:
				dic.erase("N")
			elif dic["N"] < dic["W"]:
				dic.erase("W")
			else:
				dic.erase("N")
				dic.erase("W")
	elif dic.has("S"):
		if dic.has("E"):
			if dic["S"] > dic["E"]:
				dic.erase("S")
			elif dic["S"] < dic["E"]:
				dic.erase("E")
			else:
				dic.erase("S")
				dic.erase("E")
		elif dic.has("W"):
			if dic["S"] > dic["W"]:
				dic.erase("S")
			elif dic["S"] < dic["W"]:
				dic.erase("W")
			else:
				dic.erase("S")
				dic.erase("W")
	
	if dic.has("NE"):
		if dic.has("NW"):
			if dic["NE"] > dic["NW"]:
				dic.erase("NE")
			elif dic["NE"] < dic["NW"]:
				dic.erase("NW")
			else:
				dic.erase("NE")
				dic.erase("NW")
		elif dic.has("SE"):
			if dic["NE"] > dic["SE"]:
				dic.erase("NE")
			elif dic["NE"] < dic ["SE"]:
				dic.erase("SE")
			else:
				dic.erase("NE")
				dic.erase("SE")
	elif dic.has("SW"):
		if dic.has("NW"):
			if dic["SW"] > dic["NW"]:
				dic.erase("SW")
			elif dic["SW"] < dic["NW"]:
				dic.erase("NW")
			else:
				dic.erase("SW")
				dic.erase("NW")
		elif dic.has("SE"):
			if dic["SW"] > dic["SE"]:
				dic.erase("SW")
			elif dic["SW"] < dic ["SE"]:
				dic.erase("SE")
			else:
				dic.erase("SW")
				dic.erase("SE")
	
	
	if dic.has("N"):
		if dic.has("NE"):
			if dic["N"] > dic["NE"]:
				dic.erase("N")
			elif dic["N"] < dic["NE"]:
				dic.erase("NE")
			else:
				dic.erase("N")
				dic.erase("NE")
		elif dic.has("SW"):
			if dic["N"] > dic["SW"]:
				dic.erase("N")
			elif dic["N"] < dic["SW"]:
				dic.erase("SW")
			else:
				dic.erase("N")
				dic.erase("SW")
		elif dic.has("NW"):
			if dic["N"] > dic["NW"]:
				dic.erase("N")
			elif dic["N"] < dic["NW"]:
				dic.erase("NW")
			else:
				dic.erase("N")
				dic.erase("NW")
		elif dic.has("SE"):
			if dic["N"] > dic["SE"]:
				dic.erase("N")
			elif dic["N"] < dic["SE"]:
				dic.erase("SE")
			else:
				dic.erase("N")
				dic.erase("SE")
	elif dic.has("S"):
		if dic.has("NE"):
			if dic["S"] > dic["NE"]:
				dic.erase("S")
			elif dic["S"] < dic["NE"]:
				dic.erase("NE")
			else:
				dic.erase("S")
				dic.erase("NE")
		elif dic.has("SW"):
			if dic["S"] > dic["SW"]:
				dic.erase("S")
			elif dic["S"] < dic["SW"]:
				dic.erase("SW")
			else:
				dic.erase("S")
				dic.erase("SW")
		elif dic.has("NW"):
			if dic["S"] > dic["NW"]:
				dic.erase("S")
			elif dic["S"] < dic["NW"]:
				dic.erase("NW")
			else:
				dic.erase("S")
				dic.erase("NW")
		elif dic.has("SE"):
			if dic["S"] > dic["SE"]:
				dic.erase("S")
			elif dic["S"] < dic["SE"]:
				dic.erase("SE")
			else:
				dic.erase("S")
				dic.erase("SE")
	elif dic.has("E"):
		if dic.has("NE"):
			if dic["E"] > dic["NE"]:
				dic.erase("E")
			elif dic["E"] < dic["NE"]:
				dic.erase("NE")
			else:
				dic.erase("E")
				dic.erase("NE")
		elif dic.has("SW"):
			if dic["E"] > dic["SW"]:
				dic.erase("E")
			elif dic["E"] < dic["SW"]:
				dic.erase("SW")
			else:
				dic.erase("E")
				dic.erase("SW")
		elif dic.has("NW"):
			if dic["E"] > dic["NW"]:
				dic.erase("E")
			elif dic["E"] < dic["NW"]:
				dic.erase("NW")
			else:
				dic.erase("E")
				dic.erase("NW")
		elif dic.has("SE"):
			if dic["E"] > dic["SE"]:
				dic.erase("E")
			elif dic["E"] < dic["SE"]:
				dic.erase("SE")
			else:
				dic.erase("E")
				dic.erase("SE")
	elif dic.has("W"):
		if dic.has("NE"):
			if dic["W"] > dic["NE"]:
				dic.erase("W")
			elif dic["W"] < dic["NE"]:
				dic.erase("NE")
			else:
				dic.erase("W")
				dic.erase("NE")
		elif dic.has("SW"):
			if dic["W"] > dic["SW"]:
				dic.erase("w")
			elif dic["W"] < dic["SW"]:
				dic.erase("SW")
			else:
				dic.erase("W")
				dic.erase("SW")
		elif dic.has("NW"):
			if dic["W"] > dic["NW"]:
				dic.erase("W")
			elif dic["W"] < dic["NW"]:
				dic.erase("NW")
			else:
				dic.erase("W")
				dic.erase("NW")
		elif dic.has("SE"):
			if dic["W"] > dic["SE"]:
				dic.erase("W")
			elif dic["W"] < dic["SE"]:
				dic.erase("SE")
			else:
				dic.erase("W")
				dic.erase("SE")
	print(String(dic))
	
	go_to_nearest()
	
	pass

func go_to_nearest():
	if dic.has("N"):
		if auto_enabled: $Inside_area.position = $Positions/North.position
		resultant_axis.clear()
		resultant_axis = dic.duplicate()
		print("N is nearest")
	elif dic.has("S"):
		if auto_enabled: $Inside_area.position = $Positions/South.position
		resultant_axis.clear()
		resultant_axis = dic.duplicate()
		print("S is nearest")
	elif dic.has("E"):
		if auto_enabled: $Inside_area.position = $Positions/East.position
		resultant_axis.clear()
		resultant_axis = dic.duplicate()
		print("E is nearest")
	elif dic.has("W"):
		if auto_enabled: $Inside_area.position = $Positions/West.position
		resultant_axis.clear()
		resultant_axis = dic.duplicate()
		print("W is nearest")
	elif dic.has("NE"):
		if auto_enabled: $Inside_area.position = $Positions/NorthEast.position
		resultant_axis.clear()
		resultant_axis = dic.duplicate()
		print("NE is nearest")
	elif dic.has("NW"):
		if auto_enabled: $Inside_area.position = $Positions/NorthWest.position
		resultant_axis.clear()
		resultant_axis = dic.duplicate()
		print("NW is nearest")
	elif dic.has("SE"):
		if auto_enabled: $Inside_area.position = $Positions/SouthEast.position
		resultant_axis.clear()
		resultant_axis = dic.duplicate()
		print("SE is nearest")
	elif dic.has("SW"):
		if auto_enabled: $Inside_area.position = $Positions/SouthWest.position
		resultant_axis.clear()
		resultant_axis = dic.duplicate()
		print("SW is nearest")
	else:
		if auto_enabled: $Inside_area.position = $Positions/Origin.position
		resultant_axis.clear()
		resultant_axis = dic.duplicate()
		print("No point is nearest")
	
	dic.clear()
	drag_ended = false
	print("everything happened")
	
	pass
	
