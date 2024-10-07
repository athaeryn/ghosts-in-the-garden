class_name FairyRing
extends Node2D

@export var north_sprite: Sprite2D
@export var west_sprite: Sprite2D
@export var east_sprite: Sprite2D
@export var all_lit_sprite: Sprite2D

@export var outer_detector: Area2D

@onready var audio_stream_player = %AudioStreamPlayer
const MUSHROOM_LIT = preload("res://assets/sfx/mushroom_lit.mp3")
const ALL_MUSHROOMS_LIT = preload("res://assets/sfx/all_mushrooms_lit.mp3")

signal inner_circle_entered()
signal room_entered()

var north_lit := false
var west_lit  := false
var east_lit  := false
var all_lit   := false

enum Mushroom {
	North,
	West,
	East
}

func any_lit() -> bool:
	if all_lit:
		return true
	else: if north_lit or west_lit or east_lit:
		return true
	else:
		return false

func light_mushroom(mushroom: Mushroom) -> void:
	match mushroom:
		Mushroom.North:
			north_lit = true
		Mushroom.West:
			west_lit = true
		Mushroom.East:
			east_lit = true
	if north_lit and west_lit and east_lit:
		all_lit = true


func _on_inner_detector_body_entered(body):
	if body is Player:
		inner_circle_entered.emit()
		if all_lit:
			show_lit_mushroom(all_lit_sprite)

func show_lit_mushroom(sprite: Sprite2D) -> void:
	if sprite.visible:
		return

	sprite.modulate.a = 0
	sprite.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(sprite, "modulate", Color.WHITE, 2)
	
	if sprite == all_lit_sprite:
		audio_stream_player.stream = ALL_MUSHROOMS_LIT
	else:
		audio_stream_player.stream = MUSHROOM_LIT
	audio_stream_player.play()

func _on_outer_detector_body_entered(body):
	if body is Player:
		room_entered.emit()
		if north_lit:
			show_lit_mushroom(north_sprite)
		if west_lit:
			show_lit_mushroom(west_sprite)
		if east_lit:
			show_lit_mushroom(east_sprite)
