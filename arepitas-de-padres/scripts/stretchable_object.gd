class_name StretchableObject
extends Polygon2D

@export var nodes_per_side: int = 4
@export var size: Vector2

var is_dragging: bool = false
var currently_dragging_index: int


func _ready() -> void:
	var texture_size: Vector2 = texture.get_size()
	
	var points: Array[Vector2] = []
	var uvs: Array[Vector2] = []
	
	for i in range(nodes_per_side, 0, -1):
		points.append(Vector2(0, size.y * i / nodes_per_side))
		uvs.append(Vector2(0, texture_size.y * i / nodes_per_side))
	
	for i in range(nodes_per_side):
		points.append(Vector2(size.x * i / nodes_per_side, 0))
		uvs.append(Vector2(texture_size.x * i / nodes_per_side, 0))
	
	for i in range(nodes_per_side):
		points.append(Vector2(size.x, size.y * i / nodes_per_side))
		uvs.append(Vector2(texture_size.x, texture_size.y * i / nodes_per_side))
	
	for i in range(nodes_per_side, 0, -1):
		points.append(Vector2(size.x * i / nodes_per_side, size.y))
		uvs.append(Vector2(texture_size.x * i / nodes_per_side, texture_size.y))
	
	polygon = PackedVector2Array(points)
	uv = PackedVector2Array(uvs)
	print(points)
	print(polygon)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action("drag"):
			if event.pressed:
				var mouse_pos: Vector2 = get_local_mouse_position()
				
				var best_distance: float = mouse_pos.distance_to(polygon[0])
				var best_point_index: int = 0
				
				for i in range(1, len(polygon)):
					var distance: float = mouse_pos.distance_to(polygon[i])
					
					if distance < best_distance:
						best_distance = distance
						best_point_index = i
				
				is_dragging = true
				currently_dragging_index = best_point_index
			elif is_dragging:
				is_dragging = false
				move_current_point_to_mouse()
	elif event is InputEventMouseMotion:
		if is_dragging:
			move_current_point_to_mouse()


func move_current_point_to_mouse() -> void:
	var points: Array[Vector2i] = []
	
	for point in polygon:
		points.push_back(point)
	
	points[currently_dragging_index] = get_local_mouse_position()
	
	polygon = PackedVector2Array(points)
