extends Node3D

var tree_preload = preload("res://tree.tscn")

@export var tree_num:int = 16

var margin:int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var size_x = ($TreeField.mesh.size.x-margin)/2
	var size_z = ($TreeField.mesh.size.z-margin)/2

	for i in range(tree_num):
		var tree = tree_preload.instantiate()
		
		$TreeField.add_child(tree)
		
		var r_x = randf_range(-size_x, size_x)
		var r_z = randf_range(-size_z, size_z)
		
		tree.position = Vector3(r_x, 0.0, r_z)
		
		
		
		
