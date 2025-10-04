extends CanvasLayer

signal game_over

@export var time:int = 30
var score:int = 0


func _ready() -> void:
	$CountDown.text = str(time)

func add_points (points:int):
	score += points
	
	$Score.text = str(score)
	
	$Score/AudioStreamPlayer.play()


func _on_axe_chop() -> void:
	add_points(1)


func _on_count_down_timeout() -> void:
	if time == 0:
		$Score.visible = false
		$BigScore.text = $Score.text
		$BigScore.visible = true
		$RestartButton.visible = true
		game_over.emit()
		return

	time -= 1
	$CountDown.text = str(time)
