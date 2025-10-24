extends Node2D



@export var level_data : Dictionary


@onready var timer = $Timer
@onready var enemy_manager = $Enemigos/EnemyManager


func _ready():
	load_level_data(1)
	pass

func load_level_data(level: int):


	var path = "res://DATA/DATA_LEVEL" + str(level) + ".json"
	
	
	if not FileAccess.file_exists(path):
		return
	
	var file = FileAccess.open(path, FileAccess.READ)
	
	if FileAccess.get_open_error() != OK:
		return
	
	var text = file.get_as_text()
	var json = JSON.parse_string(text)
	
	if json == null:
		return
	level_data = json
	
	enemy_manager.load_enemy_data(level_data)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	pass
	enemy_manager.next_round()
