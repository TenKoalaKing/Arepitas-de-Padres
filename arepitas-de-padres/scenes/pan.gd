extends Node2D
@export var target_arepa: Area2D
var burning_limit: float = 4.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var func_clock_die
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.has("on_pan_touch"):
		area.on_pan_touch(burning_limit)
		
	pass 


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			target_arepa.on_pan_flip(burning_limit)
		
	pass # Replace with function body.
