extends Camera2D

func _ready():
	pass 


var velocidad = 250.0

func _process(delta):
	var direction = Vector2.ZERO

	direction.x = Input.get_axis("izquierda", "derecha")
	direction.y = Input.get_axis("arriba", "abajo")

	if direction.length() > 0:
		direction = direction.normalized()
		
	global_translate(direction * velocidad * delta)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("zoom_in"):
			if zoom > Vector2(0.8, 0.8):
				zoom -= Vector2(0.1, 0.1)
			
			pass
		elif event.is_action_pressed("zoom_out"):	
			if zoom < Vector2(2.3, 2.3):
				zoom += Vector2(0.1, 0.1)
			pass
	
	
