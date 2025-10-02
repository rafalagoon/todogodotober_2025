extends Node3D


signal pipe_screwed


@onready var hand:Marker3D = $"Basic FPS Player/Head/Hand"
@onready var wrench:Node3D = $"Basic FPS Player/Head/Hand/Wrench"



func _on_pipe_selected(pipe: Variant) -> void:
	if not hand.has_node(wrench.get_path()):
		return
		
	var g_p = wrench.global_position
	var g_r = hand.global_rotation

	hand.remove_child(wrench)

	add_child(wrench)
	
	wrench.global_position = g_p
	wrench.global_rotation = g_r
	
	screw(pipe)


func screw (pipe:Node3D):
	var union = pipe.get_parent()
	var screw_position = union.get_screw_next()
	
	var first_screw:bool = true
	while screw_position:
		var t = create_tween()
		t.tween_property(wrench, "global_position", screw_position, 0.25)
		if first_screw:
			first_screw = false
			t.parallel().tween_property(wrench, "global_rotation", Vector3(deg_to_rad(-90), 0, 0), 0.2)
		
		await t.finished
		
		wrench.start_screwing()
		
		await wrench.screwed
		
		union.screwed()
		
		screw_position = union.get_screw_next()
	
	pipe_screwed.emit()


func wrench_to_hand ():
	var g_p = wrench.global_position
	var g_r = wrench.global_rotation
	var g_h_p = hand.global_position
	var g_h_r = hand.global_rotation
	
	remove_child(wrench)
	
	hand.add_child(wrench)
	
	wrench.global_position = g_p
	wrench.global_rotation = g_r
	
	var t = create_tween()
	t.tween_property(wrench, "position", Vector3.ZERO, 0.15)
	t.parallel().tween_property(wrench, "rotation", Vector3.ZERO, 0.1)


func _on_pipe_screwed() -> void:
	wrench_to_hand()


func _on_game_over() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	$CanvasLayer/UI.game_over()


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_water_level_game_over() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	$CanvasLayer/UI.game_over()
