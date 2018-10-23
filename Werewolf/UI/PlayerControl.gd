extends Node2D

var dragging = false
var drag_ended = false

var position_dictionary = {"north": 0, "south": 0, "east" : 0, "west": 0, "northeast": 0, "northwest": 0, "southeast": 0, "southwest": 0}

func _ready():
	pass


func _process(delta):
	
	drag_and_place()
	
	# To make Input Area's empty collider follow mouse position
	$Input_area.position = get_global_mouse_position()
	
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
		if $Input_area.overlaps_area($Outside_area):
			$Inside_area.position = $Input_area.position
	
	# To bring control to the correct position after drag ended
	if drag_ended:
		build_position_dictionary()
		drag_ended = false
	
	pass
	

# Brings between the control and all eight positions to the dictionary
func build_position_dictionary():
	
	position_dictionary["north"] = $Inside_area.position.distance_to(($Positions/North).position)
	position_dictionary["south"] = $Inside_area.position.distance_to(($Positions/South).position)
	position_dictionary["east"] = $Inside_area.position.distance_to(($Positions/East).position)
	position_dictionary["west"] = $Inside_area.position.distance_to(($Positions/West).position)
	position_dictionary["northeast"] = $Inside_area.position.distance_to(($Positions/NorthEast).position)
	position_dictionary["northwest"] = $Inside_area.position.distance_to(($Positions/NorthWest).position)
	position_dictionary["southeast"] = $Inside_area.position.distance_to(($Positions/SouthEast).position)
	position_dictionary["southwest"] = $Inside_area.position.distance_to(($Positions/SouthWest).position)
	
	pass
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	