extends Node3D

signal chop

func chop_chop ():
	$AnimationPlayer.speed_scale = 2.0
	$AnimationPlayer.play("chop")


func _on_chop ():
	print("On chop")
	var trees = $Pivot/Handle/Cheek/Area3D.get_overlapping_areas()
	
	for tree_area in trees:
		
		var tree:RigidBody3D = tree_area.get_parent()
		tree.freeze = false
		if tree.scoring:
			chop.emit()
			tree.scoring = false

		tree.flying()
		
		var impulse:Vector3 = to_global(Vector3.FORWARD) - global_position
		
		impulse.y = randf_range(.8, 3.0)
		impulse *= randf_range(8, 16)
		
		tree.apply_central_impulse(impulse)
		
		var dir = 1
		if randi()%2 == 0:
			dir = -1
		var rotate_value = randf_range(360, 640)*dir
		
		
		tree.apply_torque(Vector3(rotate_value,0,rotate_value))
