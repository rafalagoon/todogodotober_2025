extends Node3D

signal level_openings (num:int)
signal opening_closed

signal game_over

@export var current_level:int = 1

var faraway:float = 3000

func _ready() -> void:
	for level in get_children():
		hide_level(level)
		level.start_level.connect(_on_level_start)
		level.opening_closed.connect(_on_level_opening_closed)
		level.finished.connect(_on_level_finished)
		
	
	var level = get_node("Level"+str(current_level))

	show_level(level)
	level.start()


func show_level (level:Node3D):
	level.position.y = 0
	level.visible = true


func hide_level (level:Node3D):
	level.position.y = faraway
	level.visible = false


func next_level ():
	var level = get_node("Level"+str(current_level))
	hide_level(level)
	
	current_level += 1
	
	if not has_node("Level"+str(current_level)):
		game_over.emit()
		return
	
	level = get_node("Level"+str(current_level))
	show_level(level)
	level.start()


func _on_level_start (openings_num):
	level_openings.emit(openings_num)
	

func _on_level_opening_closed ():
	opening_closed.emit()

func _on_level_finished ():
	await get_tree().create_timer(0.5).timeout
	next_level()
	
