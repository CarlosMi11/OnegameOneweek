extends CharacterBody2D




@onready var astarmap = $"/root/Juego/Tilemap/AstarTileMap"
@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D


#variables default

@export var LIFE = 30
@export var COLOR = 1
@export var DAMAGE = 10
@export var BITS = 5



var errorMaximo = 5
@export var objetivo = Vector2(256, 365)
var dispersion = 10
var VelocidadMin = 60
var VelocidadMax = 150
var creciente : bool = true
var girar : bool = true
var direccion: Vector2 
func _ready():
	pass
	

func _physics_process(delta):
	
	# 3. Calcular la dirección y velocidad
	
	
	if velocity.length() <= VelocidadMin && !creciente:
		creciente = true
		girar = true
	elif velocity.length() >= VelocidadMax && creciente:
		creciente = false
	
	if girar:
		direccion = position.direction_to(objetivo).rotated(randf_range(-PI/8, PI/8))
		if velocity == Vector2.ZERO:
			velocity = direccion
		velocity = velocity.lerp(direccion * velocity.length(), 0.7)
		girar = false
		
		
	if creciente:
		velocity *= 1.2
	else:
		velocity *= 0.98
		
	sprite_2d.rotation = lerp_angle(sprite_2d.rotation, direccion.angle(), 0.2)

	# 5. Mover el personaje
	move_and_slide()
	

	
