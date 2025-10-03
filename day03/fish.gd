extends Node3D


signal add_points (points:int)


enum DIRECTION_AXIS {X, Z}

@export var points:int = 10


var speed_max:float = 12
var speed_min:float = 4

var water:MeshInstance3D

var speed:float = 10

var dir:int = 1
var dir_axis:DIRECTION_AXIS = DIRECTION_AXIS.Z

var dead:bool = false


func _ready() -> void:
	speed = randf_range(speed_min, speed_max)

	change_direction()

	$Points.text = "+"+str(points)



func _process(delta: float) -> void:
	if dead:
		return

	if dir_axis == DIRECTION_AXIS.Z:
		move_z(delta)
	else:
		move_x(delta)


func change_direction ():
	if randi() % 2 == 0:
		dir = -dir

	if randi() % 2 == 0:
		dir_axis = DIRECTION_AXIS.X
		rotate_x_axis()
	else:
		dir_axis = DIRECTION_AXIS.Z
		rotate_z_axis()


func rotate_x_axis ():
	if dir > 0:
		rotation_degrees.y = 90
	else:
		rotation_degrees.y = -90


func rotate_z_axis ():
	if dir > 0:
		rotation_degrees.y = 0
	else:
		rotation_degrees.y = 180


func move_x (delta):
	position.x -= dir*speed*delta

	if position.x >= water.size.x or position.x <= -water.size.x:
		dir = -dir
		
		rotate_x_axis()


func move_z (delta):
	position.z -= dir*speed*delta

	if position.z >= water.size.z or position.z <= -water.size.z:
		dir = -dir
		
		rotate_z_axis()


func die ():
	if dead:
		return

	dead = true

	var t = get_tree().create_tween()

	var dest = position

	dest.y = 15.0

	var time = randf_range(0.5, 1.5)

	t.tween_property(self, "position", dest, time)

	await t.finished

	$Model.visible = false

	$Points.visible = true

	add_points.emit(points)

	await get_tree().create_timer(0.2).timeout
	
	visible = false
