class_name ScrollCamera
extends Camera2D

@export var scroll_h: bool
@export var scroll_v: bool
@export var bounding_sprite: Sprite2D


func _input(event: InputEvent) -> void:
	var bounding_sprite_size: Vector2 = bounding_sprite.texture.get_size() * bounding_sprite.scale
	var upper_bounds: Vector2 = bounding_sprite_size - Vector2(get_viewport().size)
	
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("drag"):
			if scroll_h:
				if position.x - event.relative.x < 0:
					position.x = 0
				elif position.x - event.relative.x > upper_bounds.x:
					position.x = upper_bounds.x
				else:
					position.x -= event.relative.x
			if scroll_v:
				if position.y - event.relative.y < 0:
					position.y = 0
				elif position.y - event.relative.y > upper_bounds.y:
					position.y = upper_bounds.y
				else:
					position.y -= event.relative.y
