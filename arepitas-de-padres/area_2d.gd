extends Area2D


var isBurning : bool = false
var shake_strenght: float = 10.0
var original_position: Vector2
var is_in_drag: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	original_position = position
	$normalArepa.show()
	$burningArepa.hide()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#shake_arepa()
	if is_in_drag:
		position = get_global_mouse_position()	
	pass
	

	
#Arepa Shake
# @trace SREQ-001B @
func shake_arepa():
	if shake_strenght > 0:
		shake_strenght = lerp(shake_strenght, 0.0, 0.5)
		position = Vector2(randf_range(-shake_strenght, shake_strenght), randf_range(-shake_strenght, shake_strenght))
		
	if shake_strenght <= 0.1:
		shake_strenght = 0
		position = original_position


# @trace SREQ-001B @
# Hit the pan at the beggining as a starter
func on_pan_touch(burning_limit: int):
	$normalArepa.show()
	$Timer.start(burning_limit)

	#Shake the arepa a little bit
	shake_arepa()
	
# Defines action that avoids overcooked arepa
# @trace SREQ-001B @	
func on_pan_flip(burning_limit: int):
	shake_arepa()
	$Timer.stop()
	on_pan_touch(burning_limit)

# @trace SREQ-001A @
func _on_timer_timeout() -> void:
	$normalArepa.hide()
	$burningArepa.show()
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
