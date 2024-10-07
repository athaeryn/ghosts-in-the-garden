class_name Room
extends Area2D

@export var fairy_ring: FairyRing
@export var mushroom: FairyRing.Mushroom = FairyRing.Mushroom.North

signal player_entered()

var ghosts_left = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	var ghosts = get_ghosts()
	ghosts_left = ghosts.size()
	for ghost in ghosts:
		ghost.died.connect(_on_ghost_died, CONNECT_ONE_SHOT)
		
func room_complete():
	var frog = get_frog()
	if frog:
		frog.set_free()
	fairy_ring.light_mushroom(mushroom)

func _on_ghost_died():
	ghosts_left -= 1
	if ghosts_left == 0:
		room_complete()

func get_frog() -> Frog:
	var children = get_children()
	for child in children:
		if child is Frog:
			return child
	return null

func get_ghosts() -> Array[Ghost]:
	var ghosts: Array[Ghost] = []
	var children = get_children()
	for child in children:
		if child is Ghost:
			ghosts.push_back(child)
	return ghosts

func _on_body_entered(body):
	if body is Player:
		player_entered.emit()
