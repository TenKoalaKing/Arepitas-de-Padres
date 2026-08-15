extends Node2D


func _ready() -> void:
	self.hide() 





func _on_area_2d_mouse_entered() -> void:
	self.show()

func _on_area_2d_mouse_exited() -> void:
	self.hide()
