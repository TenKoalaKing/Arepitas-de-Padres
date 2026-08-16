class_name Arepa
extends Area2D

@export var collision_shape: CollisionPolygon2D
@export var timer: Timer


var isBurning : bool = false
var shake_strenght: float = 10.0
var original_position: Vector2
var is_in_drag: bool = false
var is_arepa_burned: bool = false

# Vars to track the burning sides
# @trace SREQ-001A @
var side_burn_limit: float = 120
var is_side_A: bool = true
var burning_level_side_A : float = 0
var burning_level_side_B : float = 0
var pan_target : Node2D

# Called when the node enters the scene tree for the first time.
var burning_limit = 0.0

func _ready() -> void:
	collision_shape.polygon = $normalArepa.polygon
	original_position = global_position
	$normalArepa.show()
	$burningArepa.hide()
	# @trace SREQ-001A @
	if pan_target != null:
		burning_limit = pan_target.burning_limit
		print("Pan burning limit extracted:", burning_limit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#shake_arepa()
	if is_in_drag:
		position = (get_parent() as Node2D).get_local_mouse_position()
		
	# @trace SREQ-001A @
	if not $Timer.is_stopped() and not is_arepa_burned and burning_limit > 0:
		
		if is_side_A: 
			burning_level_side_A +=  delta * 10
			print("DEBUG: SIDE A - burn level: ",burning_level_side_A )
		else:
			burning_level_side_B +=  delta * 10
			print("DEBUG: SIDE B - burn level: ",burning_level_side_B )
		
		
	if burning_level_side_A >= side_burn_limit || burning_level_side_B >= side_burn_limit:
		
		if not is_arepa_burned:
			is_arepa_burned = true
			apply_burn_effect()


func enable_stretching() -> void:
	$normalArepa.stretch_enabled = true


func disable_stretching() -> void:
	$normalArepa.stretch_enabled = false
	$burningArepa.polygon = $normalArepa.polygon
	collision_shape.polygon = $normalArepa.polygon


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
	# Start the arepa burn for side A
	$normalArepa.show()
	$Timer.start(burning_limit)
	
	#Shake the arepa a little bit
	shake_arepa()


# Defines action that avoids overcooked arepa
# @trace SREQ-001B @	
func on_pan_flip(burning_limit: float):
	if !is_arepa_burned:
		is_side_A = !is_side_A
		shake_arepa()
		$Timer.stop()
		on_pan_touch(burning_limit)


# @trace SREQ-001A @
func apply_burn_effect():
	$normalArepa.hide()
	$burningArepa.show()
	var tween = get_tree().create_tween()
	var burned_color = Color("#1F150C")
	tween.tween_property($burningArepa, "modulate", burned_color, 1.5)


func _on_timer_timeout() -> void:
	$normalArepa.hide()
	$burningArepa.show()
	apply_burn_effect()
	is_arepa_burned = true


# @trace SREQ-001C @
func _on_input_event(viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				is_in_drag = true
				get_viewport().set_input_as_handled()

# @trace SREQ-001C @
func _input(event):
	if event is InputEventMouseButton:
		if is_in_drag:
			is_in_drag = false
			get_viewport().set_input_as_handled()
	elif event is InputEventMouseMotion:
		if is_in_drag:
			get_viewport().set_input_as_handled()
