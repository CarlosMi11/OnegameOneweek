extends TileMapLayer

@onready var astar = AStarGrid2D.new()

func _ready():
	cargarValores()

func cargarValores():
	var mapRect = get_used_rect()
	var mapSizeX = mapRect.size.x
	var mapSizeY = mapRect.size.y
	astar.region = Rect2i(mapRect.position.x, mapRect.position.y, mapSizeX, mapSizeY)
	astar.cell_size = tile_set.tile_size
	astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_CHEBYSHEV
	astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_CHEBYSHEV
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.update() 
	
	
	for x in range(mapRect.position.x, mapRect.end.x):
		for y in range(mapRect.position.y, mapRect.end.y):
			var coord = Vector2(x, y)
			
			if get_cell_atlas_coords(coord) != Vector2i(-1,-1):
				astar.set_point_weight_scale(coord, get_cell_tile_data(coord).get_custom_data("PesoCaminoTerrestre"))
			else:
				astar.set_point_solid(coord, true)
			
func encontrarCamino(pos1 : Vector2, pos2 : Vector2) -> PackedVector2Array:
	var coordIni = local_to_map(to_local(pos1))
	var coordFin = local_to_map(to_local(pos2))
	
	var rutaDiscreta = astar.get_point_path(coordIni, coordFin)

	return rutaDiscreta

func lockTile(pos1 : Vector2i):
	if !astar.is_point_solid(pos1):
		astar.set_point_solid(pos1, true)

func lockArea(pos1 : Vector2i, pos2 : Vector2i):
	for x in range(pos1.x, pos2.x):
		for y in range(pos1.y, pos2.y):
			lockTile(Vector2i(x, y))

func unlockTile(pos1 : Vector2i):
	if astar.is_point_solid(pos1):
		astar.set_point_solid(pos1, false)
func unlockArea(pos1 : Vector2i, pos2 : Vector2i):
	for x in range(pos1.x, pos2.x):
		for y in range(pos1.y, pos2.y):
			unlockTile(Vector2i(x, y))

func changeWeight(pos1: Vector2i, valor : float):
	astar.set_point_weight_scale(pos1, valor)

func isInside(pos : Vector2) -> bool:    
	# Si los datos NO son null, hay un tile.
	return get_cell_tile_data(local_to_map(to_local(pos))) != null
	
func _process(delta):
	pass
