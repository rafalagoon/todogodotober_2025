extends RigidBody3D


var t_min:float = 0.75
var t_max:float = 2.0

var exploded:bool = false


func _ready() -> void:
	#$Timer.wait_time = randf_range(t_min, t_max)
	$Timer.start()
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		explosion()
	
	

func explosion () -> void:
	if exploded:
		return
	
	exploded = true
		
	print("BOOOOOOOOOOOOOMBA")
	$Area3D/CollisionShape3D.disabled = false
	
	
	var g_p = global_position
	var g_r = global_rotation
	
	var explosion = $Explosion
	var water_explosion = $WaterExplosion
	
	remove_child(explosion)
	remove_child(water_explosion)
	
	
	get_parent().add_child(explosion)
	get_parent().add_child(water_explosion)
	
	explosion.global_position = g_p
	explosion.global_rotation = g_r
	
	water_explosion.global_position = g_p
	water_explosion.global_rotation = g_r
	
	$AudioStreamPlayer3D.play()
	
	var t = create_tween()
	t.tween_property(explosion, "scale", Vector3.ONE, 0.2)
	
	await t.finished
	
	var fish = $Area3D.get_overlapping_areas()
	
	for f in fish:
		f.get_parent().die()

	await get_tree().create_timer(0.05).timeout

	visible = false

	explosion.visible = false
	
	water_explosion.visible = true
	
	t = create_tween()
	t.tween_property(water_explosion, "position:y", 14, 0.2)
	
	await t.finished
	
	
	
	water_explosion.visible = false
	

	


func _on_timer_timeout() -> void:
	explosion()
