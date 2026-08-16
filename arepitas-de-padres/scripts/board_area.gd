class_name BoardArea
extends Area2D

var current_arepa: Arepa


func _on_area_entered(area: Area2D) -> void:
	if not area is Arepa:
		return
	
	if current_arepa:
		return
	
	var arepa: Arepa = area
	current_arepa = arepa
	
	current_arepa.enable_stretching()


func _on_area_exited(area: Area2D) -> void:
	if area != current_arepa:
		return
	
	current_arepa.disable_stretching()
	current_arepa = null
