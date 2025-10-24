extends Area2D

var enemiesToGenerate : Array[PackedScene]
@export var radius : float = 120
@export var rate : float = 0.5



func _ready():
	
	pass

func genEnemies(turno : int) -> Array[CharacterBody2D]:
	#genera enemigos aleatorios a partir de un turno. Asume la siguiente metadata en las
	#escenas de enemiesToGenerate:
	#InitialTurn : int = (turno donde debe aparecer por primera vez un tipo de enemigo)
	#SpawnMultiplier : float = (un multiplicador de cuantos deben aparecer por turno, formula "Turno*Multiplier") 
	var hay = false
	var index : Array[int] 
	for i in range(enemiesToGenerate.size):
		if enemiesToGenerate[i].get_meta("InitialTurn") == turno:
			hay = true
			index.append(i)
	var generados : Array[CharacterBody2D] = []
	if hay:
		for i in index:
			var multiplicador = enemiesToGenerate[i].get_meta("SpawnMultiplier")
			for j in range(floor(turno * multiplicador)):
				var new_enemy : CharacterBody2D = enemiesToGenerate[i].instantiate()
				var pos = global_position + Vector2(cos(randf_range(0, TAU)) * randf_range(0, radius), sin(randf_range(0, TAU)) * randf_range(0, radius))
				new_enemy.global_position = pos
				generados.append(new_enemy)
	else:
		for i in range(enemiesToGenerate.size):
			var multiplicador = enemiesToGenerate[i].get_meta("SpawnMultiplier")
			for j in range(floor(turno * multiplicador)):
				var new_enemy : CharacterBody2D = enemiesToGenerate[i].instantiate()
				var pos = global_position + Vector2(cos(randf_range(0, TAU)) * randf_range(0, radius), sin(randf_range(0, TAU)) * randf_range(0, radius))
				new_enemy.global_position = pos
				generados.append(new_enemy)
				
				
	for i in range(generados.size()):
		get_parent().add_child(generados[i])
	
	return generados
	
func startSpawn(array : Array[int]) -> Array[Node]:
	#Recibe un arreglo del mismo tamaño que enemiesToGenerate, donde cada entrada es la cantidad de esos
	#enemigos a generar
	print("entra")
	var generados : Array[Node] = []
	for i in range(array.size()):
		for k in range(array[i]):
			var pos = global_position + Vector2(cos(randf_range(0, TAU)) * randf_range(0, radius), sin(randf_range(0, TAU)) * randf_range(0, radius))
			var new_enemy : Node = enemiesToGenerate[i].instantiate()
			new_enemy.global_position = pos
			new_enemy.z_index = 2
			print(pos)
			get_parent().add_child(new_enemy)
			print(get_parent().name)
			generados.append(new_enemy)
			await get_tree().create_timer(0.1).timeout
	
	return generados

func changeEnemiesToGenerate(enemiesToGenerate_ : Array[PackedScene]):
	enemiesToGenerate = enemiesToGenerate_
	
func _process(delta):
	pass
