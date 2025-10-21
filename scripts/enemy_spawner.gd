extends Area2D

@export var enemiesToGenerate : Array[PackedScene]
@export var radius : float = 120
@export var rate : float = 0.5



func _ready():
	
	pass

func genEnemies(turno : int) -> Array[Node]:
	var hay = false
	var index : Array[int] 
	for i in range(enemiesToGenerate.size):
		if enemiesToGenerate[i].get_meta("InitialTurn") == turno:
			hay = true
			index.append(i)
	var generados : Array[Node] = []
	if hay:
		for i in index:
			var multiplicador = enemiesToGenerate[i].get_meta("SpawnMultiplier")
			for j in range(floor(turno * multiplicador)):
				var new_enemy : Node = enemiesToGenerate[i].instantiate()
				var pos = global_position + Vector2(cos(randf_range(0, TAU)) * randf_range(0, radius), sin(randf_range(0, TAU)) * randf_range(0, radius))
				new_enemy.global_position = pos
				generados.append(new_enemy)
	else:
		for i in index:
			var multiplicador = enemiesToGenerate[i].get_meta("SpawnMultiplier")
			for j in range(floor(turno * multiplicador)):
				var new_enemy : Node = enemiesToGenerate[i].instantiate()
				var pos = global_position + Vector2(cos(randf_range(0, TAU)) * randf_range(0, radius), sin(randf_range(0, TAU)) * randf_range(0, radius))
				new_enemy.global_position = pos
				generados.append(new_enemy)
	for i in range(generados.size()):
		get_parent().add_child(generados[i])
	
	return generados
	
func startSpawn(array : Array[int]) -> Array[Node]:
	var generados : Array[Node] = []
	for i in range(generados.size()):
		get_parent().add_child(generados[i])
	
	return generados
	
func _process(delta):
	pass
