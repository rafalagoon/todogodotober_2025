extends Node3D



func _on_out_bounds_area_3d_body_entered(body: Node3D) -> void:
	get_tree().reload_current_scene()


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
