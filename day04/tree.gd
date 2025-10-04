extends RigidBody3D


var scoring = true
var sound:bool = true
var flying_counter:int = 0
var flying_counter_prev:int = 0
var prev_pos:Vector3 = Vector3.ZERO

func _ready() -> void:
	set_process(false)
	
	prev_pos = position

func _process(delta: float) -> void:
	print(position.distance_to(prev_pos) )
	if flying_counter >= 2:
		if position.distance_to(prev_pos) < 0.1:
			flying_counter = 5
			$AudioStreamPlayer3D.stop()
			set_process(false)
	if flying_counter != flying_counter_prev:
		prev_pos = position
		flying_counter_prev = flying_counter

func flying ():
	set_process(true)
	$AudioStreamPlayer3D.play()


func _on_audio_stream_player_3d_finished() -> void:
	if flying_counter > 4:
		return
		
	flying_counter += 1
	
	$AudioStreamPlayer3D.play()
