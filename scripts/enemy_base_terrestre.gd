class_name EnemyBase

extends CharacterBody2D


@export var velocidad = 120.0

@onready var astarmap = $"../Tilemap/AstarTileMap"

#variables default

@export var LIFE = 30
@export var COLOR = 1
@export var DAMAGE = 10
@export var BITS = 5

#variables de ruta
var ruta : PackedVector2Array = []
var posActual = 0
var errorMaximo = 5
@export var objetivo = Vector2(256, 365)
var dispersion = 10

func _ready():
	pass
	
func calcularRuta():
	var rutaAux = astarmap.encontrarCamino(position, objetivo)
	
	for i in range(rutaAux.size()):
		if(i%2 == 0):
			var apend : Vector2
			apend = rutaAux[i] + Vector2(randf_range(-1, 1) * dispersion, randf_range(-1, 1) * dispersion)
			if astarmap.isInside(apend) :
				ruta.append(apend)
			else:
				ruta.append(rutaAux[i])
	

func _physics_process(delta):
	if ruta.is_empty():
		calcularRuta()

	if global_position.distance_to(objetivo) <= errorMaximo or posActual >= ruta.size():
		velocity = Vector2.ZERO
		move_and_slide()
		return

   	# 2. Obtener la posición del próximo punto
	var puntoObjetivo: Vector2 = ruta[posActual]
	
	# 3. Calcular la dirección y velocidad
	var direccion: Vector2 = position.direction_to(puntoObjetivo)
	
	velocity = (direccion) * velocidad * delta
	
	# 4. Verificar si llegó al punto actual 
	
	if position.distance_to(puntoObjetivo) < errorMaximo: # Tolerancia de 5 píxeles (punto de llegada
		posActual += 1

	# 5. Mover el personaje
	move_and_slide()
	

	
