extends AudioStreamPlayer

@onready var audio_stream_player = %AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	audio_stream_player.finished.connect(_on_player_finished)

func _on_player_finished():
	audio_stream_player.play()
