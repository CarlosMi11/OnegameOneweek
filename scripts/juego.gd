extends Node2D


@onready var timer = $Timer

@onready var spawner = $Enemigos/Spawner
# Called when the node enters the scene tree for the first time.
func _ready():
	var enemy_types : Array[PackedScene] = [preload("res://scenes/enemyBaseTerrestre.tscn")]
	
	enemy_types[0].set_meta("InitialTurn", int(1))
	enemy_types[0].set_meta("SpawnMultiplier", int(1.3))
	
	spawner.changeEnemiesToGenerate(enemy_types)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var a : Array[int] = [5]
	spawner.startSpawn(a)
