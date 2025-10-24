extends Node2D


@onready var spawner = $"../Spawner"

@export var enemyList : Array[Node] = []
@export var actualRound : int = 1
@export var enemyToGenerate : Array[PackedScene] = []
var enemiesPerRound : Array



func _ready():
	pass 


func castToInt(arr : Array) -> Array[int]:
	var ret : Array[int] = []
	for value in arr:
		ret.push_back(int(value))
		
	return ret


func load_enemy_data(data : Dictionary):

	enemyToGenerate.clear()
	enemiesPerRound.clear()
	
	for scene in data["enemies"]:
		enemyToGenerate.append(load(scene))
	
	
	for cant in data["rounds"]:
		
		enemiesPerRound.append(castToInt(cant))
	

func next_round():
	if enemyList.is_empty():
		enemyList = await spawner.startSpawn(enemiesPerRound[actualRound-1])
		actualRound+=1
