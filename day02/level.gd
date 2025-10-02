extends Node3D

signal start_level (openings_num:int)
signal opening_closed
signal finished

var unions:int = 0
var openings_num:int = 0

func _ready() -> void:
	for pipe in get_children():
		for union in pipe.get_children():
			if not union.has_meta("is_union"):
				continue
				
			unions += 1
			openings_num += union.opening_size
			union.closed.connect(_on_closed)
			union.opening_closed.connect(_on_opening_closed)


func start ():
	print(openings_num)
	
	start_level.emit(openings_num)
	for pipe in get_children():
		if pipe.has_node("PipeUnion"):
			pipe.get_node("PipeUnion").start()


func _on_opening_closed ():
	opening_closed.emit()


func _on_closed ():
	unions -= 1
	
	if unions == 0:
		finished.emit()
