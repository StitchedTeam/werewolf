extends Node2D

var dragging = false
var drag_ended = false

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
	
	# To bring control to the right position after drag ended
	if drag_ended:
		var north = $Inside_area.position.distance_to($Positions/North)
		var south = $Inside_area.position.distance_to($Positions/South)
		var east = $Inside_area.position.distance_to($Positions/East)
		var west = $Inside_area.position.distance_to($Positions/West)
		var northeast = $Inside_area.position.distance_to($Positions/Northeast)
		var northwest = $Inside_area.position.distance_to($Positions/Northwest)
		var southeast = $Inside_area.position.distance_to($Positions/SouthEast)
		var southwest = $Inside_area.position.distance_to($Positions/SouthWest)
		
		
		#if
	
	pass