extends Area2D


var isBurning : bool = false
var shake_strenght: float = 10.0
var original_position: Vector2
var is_in_drag: bool = false
var is_arepa_burned: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	original_position = global_position
	$normalArepa.show()
	$burningArepa.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#shake_arepa()
	if is_in_drag:
		position = get_global_mouse_position()	
	

	
#Arepa Shake
# @trace SREQ-001B @
func shake_arepa():
	if shake_strenght > 0.1:
		shake_strenght = lerp(shake_strenght, 0.0, 0.5)
		global_position = original_position + Vector2(randf_range(-shake_strenght, shake_strenght), randf_range(-shake_strenght, shake_strenght))
	elif shake_strenght > 0:
		shake_strenght = 0.0
		global_position = original_position


# @trace SREQ-001B @
# Hit the pan at the beggining as a starter
func on_pan_touch(burning_limit: float):
	print("Pan started or restarted")
	$normalArepa.show()
	$Timer.start(burning_limit)
	#Shake the arepa a little bit
	shake_arepa()
	
	
# Defines action that avoids overcooked arepa
# @trace SREQ-001B @	
func on_pan_flip(burning_limit: float):
	if !is_arepa_burned:
		shake_arepa()
		$Timer.stop()
		on_pan_touch(burning_limit)
	
		

# @trace SREQ-001A @
func apply_burn_effect():
	var tween = get_tree().create_tween()
	var burned_color = Color("#1F150C")
	tween.tween_property($burningArepa, "modulate", burned_color, 1.5)
	
	
func _on_timer_timeout() -> void:
	$normalArepa.hide()
	$burningArepa.show()
	apply_burn_effect()
	is_arepa_burned = true
	
	
	# Please add the logic of the burning game is lost
	# or bad effect on the user
	

# @trace SREQ-001C @
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				is_in_drag = true
	pass # Replace with function body.
	
# @trace SREQ-001C @
func _input(event):
	if event is InputEventMouseButton:
		if !event.pressed:
			is_in_drag = false
