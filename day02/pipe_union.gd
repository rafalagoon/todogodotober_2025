extends Node3D

signal opening_closed
signal closed

@export var force_emitting:bool = false
var particles_quantity:int = 16

@export_range(0,4) var opening_size:int = 0
var opening_size_max:int = 4

var timer_min:float = 2.0
var timer_max:float = 8.0

var screw_current:int = 0

var selected:bool = false

@export var force_start:bool = false


func _ready() -> void:
	if force_emitting:
		water()
		return
	
	if force_start:
		start_timer()


func start ():
	start_timer()


func get_screw_next ():
	if opening_size <= 0:
		return false

	screw_current += 1
	
	return get_node("Union/Screw"+str(screw_current)+"/Marker3D").global_position


func get_particles_quantity (num):
	var quantity = 0
	if num == 1:
		quantity = 1
	elif num == 2:
		quantity = 2
	elif num == 3:
		quantity = 4
	elif num == 4:
		quantity = 6
		
	return quantity

func screwed ():
	opening_size -= 1
	opening_closed.emit()
	
	if opening_size <= 0:
		$GPUParticles3D.emitting = false
		closed.emit()
		return
	
	var quantity = get_particles_quantity(opening_size)

	$GPUParticles3D.amount = quantity*particles_quantity


func water ():
	print("wat")
	if $GPUParticles3D.emitting:
		await $GPUParticles3D.finished
	
	var amount = get_particles_quantity(opening_size)
	if amount <= 0:
		$GPUParticles3D.emitting = false
		$AudioStreamPlayer3D.stop()
		return

	if not $AudioStreamPlayer3D.playing:
		$AudioStreamPlayer3D.play()
	print("wat2")
	$GPUParticles3D.amount = amount*particles_quantity
	$GPUParticles3D.emitting = true


func start_timer ():
	if not $Timer.is_stopped():
		return
		
	var t = randf_range(timer_min, timer_max)
	$Timer.wait_time = t
	$Timer.start()


func _on_timer_timeout() -> void:
	#water()
	pass
