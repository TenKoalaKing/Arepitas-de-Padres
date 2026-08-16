class_name BoardArea
extends Area2D

var current_arepa: Arepa = null


func _on_area_entered(area: Area2D) -> void:
	if not area is Arepa:
		return
	
	if current_arepa:
		return
	
	current_arepa = area
	
	current_arepa.enable_stretching()


func _on_area_exited(area: Area2D) -> void:
	if area != current_arepa:
		return
	
	current_arepa.disable_stretching.call_deferred()
	current_arepa = null
