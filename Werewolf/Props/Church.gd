extends Area2D

export var area = int()
var church = true
var player

func _ready():
	load_church()
	pass

func _process(delta):
	die()
	pass

func load_church():
	if !GameGlobals.church_exists.has(String(area)):
		$Sprite.frame = 1
		church = false
	pass

func die():
	if !GameGlobals.priest_alive.has(String(area)) && (GameGlobals.enemies_alive[String(area)] == 0):
		if church:
			$StaticBody2D/CollisionShape2D.set_disabled(true)
			if overlaps_body(player):
				player.on_transform_end()
				$Sprite.frame = 1
				church = false
				GameGlobals.church_exists.erase(String(area))
				GameGlobals.save(GameGlobals.build_save())
		elif !overlaps_body(player):
			$StaticBody2D/CollisionShape2D.set_disabled(false)
	pass