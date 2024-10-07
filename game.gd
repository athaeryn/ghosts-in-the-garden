class_name Game
extends Node2D

@onready var fairy_ring = %FairyRing
@onready var north_room: Room = %NorthRoom
@onready var east_room: Room = %EastRoom
@onready var west_room: Room = %WestRoom

signal show_message(message: String)

var have_shown_first_message = false
var have_shown_help_frog_message = false

func _ready():
	for room in [north_room, west_room, east_room]:
		room.player_entered.connect(_on_player_entered_room, CONNECT_ONE_SHOT)
	fairy_ring.room_entered.connect(_on_player_entered_fairy_ring_room, CONNECT_ONE_SHOT)

func _on_player_entered_room():
	if have_shown_help_frog_message:
		return
	have_shown_help_frog_message = true
	show_message.emit("frog_needs_help")

func _on_player_entered_fairy_ring_room():
	if have_shown_first_message:
		return
	have_shown_first_message = true
	show_message.emit("something_wrong")

func _on_fairy_ring_inner_circle_entered():
	if not fairy_ring.any_lit():
		show_message.emit("anyone_in_trouble")
	else: if not fairy_ring.all_lit:
		show_message.emit("keep_looking")
	else:
		show_message.emit("i_did_it")
