extends Node3D

signal screwed


func start_screwing ():
	$AnimationPlayer.play("screw")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	screwed.emit()
