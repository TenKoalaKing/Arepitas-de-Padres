class_name StretchableObject
extends Polygon2D

@export var goal_size_mult: float = 5
@export var nodes_per_side: int = 4
@export var size: Vector2

var stretch_enabled: bool = false
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


func _input(event: InputEvent) -> void:
	if not stretch_enabled:
		return
	
	var mouse_pos: Vector2 = get_local_mouse_position()
	
	if event is InputEventMouseButton:
		if event.is_action("drag"):
			if event.pressed:
				if Geometry2D.is_point_in_polygon(mouse_pos, polygon):
					get_viewport().set_input_as_handled()
					
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
				if get_area(polygon) >= goal_size_mult * size.x * size.y:
					stretch_enabled = false
					print(get_area(polygon))
	elif event is InputEventMouseMotion:
		if is_dragging:
			var shifted_point = polygon[currently_dragging_index] + event.relative
			if not Geometry2D.is_point_in_polygon(shifted_point, polygon):
				move_current_point_to_mouse(event.relative)
				get_viewport().set_input_as_handled()


func move_current_point_to_mouse(shift: Vector2) -> void:
	var points: Array[Vector2] = []
	
	for point in polygon:
		points.push_back(point)
	
	points[currently_dragging_index] += shift
	
	var old_polygon = polygon
	polygon = PackedVector2Array(points)
	if get_area(old_polygon) >= get_area(polygon):
		polygon = old_polygon
	else:
		get_viewport().set_input_as_handled()


func get_area(points: PackedVector2Array) -> float:
	var area: float = 0
	
	for i in range(len(points)):
		var point_1: Vector2 = points[i]
		var point_2: Vector2
		if i < len(points) - 1:
			point_2 = points[i + 1]
		else:
			point_2 = points[0]
		
		area += 0.5 * (point_1.x - point_2.x) * (point_1.y + point_2.y)
	
	area = abs(area)
	
	return area
