extends Node3D

signal game_over

@onready var water_level_start_y:float = position.y
@onready var game_over_y:float = $Water.mesh.size.y

@export var opening_speed:float = 0.05
var opening_num:float = 1.0

var max_score:float = 100

func _ready() -> void:
	position.y = water_level_start_y


func _process(delta: float) -> void:
	position.y += opening_speed*opening_num*delta
	var ui = get_parent().get_node("CanvasLayer/UI")

	ui.get_node("WaterLevel").text = str(opening_num)+" "+str(position.y)

	if position.y > 0:
		var score:int = int(max_score - (position.y*max_score/game_over_y))
		ui.update_score(score)
		
		if score == 0:
			set_process(false)
			game_over.emit()
			


func _on_level_manager_level_openings(num: int) -> void:
	opening_num = num


func _on_level_manager_opening_closed() -> void:
	opening_num -= 1
	
	if opening_num <= 0:
		opening_num = 0
