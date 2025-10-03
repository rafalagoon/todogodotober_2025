extends MeshInstance3D

signal add_points (points:int)

var fish_preload = preload("res://fish.tscn")

@export var fish_num:int = 32

var margin:float = 1.0
var margin_init:float = 1.0

var size:Vector3 = Vector3.ZERO

func _ready() -> void:
	
	var sound_start:float = randf_range(0.0, 120.0)
	
	$AudioStreamPlayer.play()
	$AudioStreamPlayer.seek(sound_start)
	
	size.x = (mesh.size.x-margin)/2
	size.y = (mesh.size.y-margin)/2
	size.z = (mesh.size.z-margin)/2
	
	var size_x = size.x - margin_init
	var size_y = size.y - margin_init
	var size_z = size.z - margin_init
	
	for f in range(fish_num):
		var fish = fish_preload.instantiate()
		
		add_child(fish)
		
		fish.water = self

		fish.position.x = randf_range(-size_x, size_x)
		fish.position.y = randf_range(-size_y, size_y)
		fish.position.z = randf_range(-size_z, size_z)
		
		
		fish.add_points.connect(_on_add_points)


func _on_add_points (points:int):
	add_points.emit(points)
