extends Node

@onready var sub_viewport_container = %SubViewportContainer
@onready var sub_viewport = %SubViewport

@onready var something_wrong: Message = %SomethingWrong
@onready var anyone_in_trouble: Message = %AnyoneInTrouble
@onready var frog_needs_help = %FrogNeedsHelp
@onready var keep_looking = %KeepLooking
@onready var i_did_it = %IDidIt

func _ready():
	Global.viewport = sub_viewport
	Global.viewport_container = sub_viewport_container

var message_queue: Array[String] = []
var displaying_message: Message = null

func _on_game_show_message(message):
	message_queue.push_back(message)
	
func _on_message_display_timeout():
	if displaying_message:
		displaying_message.disappear()
	displaying_message = null

func _process(_delta):
	if not displaying_message and message_queue.size() > 0:
		var message_name = message_queue.pop_front()
		match message_name:
			"something_wrong":
				displaying_message = something_wrong
			"anyone_in_trouble":
				displaying_message = anyone_in_trouble
			"frog_needs_help":
				displaying_message = frog_needs_help
			"keep_looking":
				displaying_message = keep_looking
			"i_did_it":
				displaying_message = i_did_it

		if displaying_message:
			displaying_message.appear()
			var timer = get_tree().create_timer(4)
			timer.timeout.connect(_on_message_display_timeout, CONNECT_ONE_SHOT)
