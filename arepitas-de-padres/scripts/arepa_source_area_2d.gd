class_name ArepaSourceArea2D
extends Area2D

@export var arepa_scene: PackedScene

@export var interior: Sprite2D

var mouse_inside: bool = false


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("drag"):
			if event.pressed and mouse_inside:
				var arepa: Area2D = arepa_scene.instantiate()
				interior.add_child(arepa)


func _mouse_enter() -> void:
	mouse_inside = true


func _mouse_exit() -> void:
	mouse_inside = false
