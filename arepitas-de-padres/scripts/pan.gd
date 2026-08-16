extends Node2D
@export var target_arepa: Node

var burning_limit: float = 4.0

# Pan Down counter
# @trace SREQ-001A @
@onready var timer_label = $CanvasLayer/TimerText




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
# @trace SREQ-001A @
func _process(delta: float) -> void:
	
	var arepa_timer = target_arepa.get_node_or_null("Timer")
	
	if arepa_timer:
			timer_label.text = str(ceil(arepa_timer.time_left))
	
	if target_arepa.is_arepa_burned:
		timer_label.text = "This arepa is overcoked"
		
		
var func_clock_die
func _on_area_2d_area_entered(area: Area2D) -> void:
	print("Arepa tocuh pan!!!!")
	if area.has_method("on_pan_touch"):
		area.on_pan_touch(burning_limit)
		


# @trace SREQ-001C @ 
# Handles arepa place over a pan
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				print('This should flip the pan')
				target_arepa.on_pan_flip(burning_limit)
		
