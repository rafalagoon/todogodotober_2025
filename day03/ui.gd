extends CanvasLayer


var score:int = 0


func add_points (points:int):
	score += points
	
	$Score.text = str(score)
	
	$Score/AudioStreamPlayer.play()
	
	$RestartTimer.stop()
	$RestartTimer.start()


func _on_water_add_points(points: int) -> void:
	add_points(points)


func _on_restart_timer_timeout() -> void:
	$RestartButton.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
