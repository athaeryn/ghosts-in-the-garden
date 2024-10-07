class_name GhostDefeatedState
extends GhostState

func enter():
	ghost.play_animation("defeated")
	ghost.sfx_defeated()
	ghost.emit_died()
	ghost.sprite.animation_finished.connect(_on_done, CONNECT_ONE_SHOT)
	
func _on_done():
	ghost.queue_free()
