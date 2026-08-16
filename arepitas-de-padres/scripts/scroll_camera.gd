class_name ScrollCamera
extends Camera2D

@export var scroll_h: bool
@export var scroll_v: bool
@export var bounding_sprite: Sprite2D
@export var screen_overlay: ColorRect
@export var section_positions: Array[Vector2]
@onready var board_node = $board_thingy
@export var game_path:NodePath
@onready var game_script = get_node(game_path)
@export var customer_scripts: Array[AnimatedSprite2D]
@export var numberf := 0 #int 1- 8
@onready var nodef := $/root/Game/CustomerScreen/Node/customer
@export var onef_path:NodePath
@onready var onef = get_node(onef_path)
@export var twof_path:NodePath
@onready var twof = get_node(twof_path)
@export var threef_path:NodePath
@onready var threef = get_node(threef_path)
@export var fourf_path:NodePath
@onready var fourf = get_node(fourf_path)
var current_order := []
func _ready() -> void:
	await wait_time(.1)
	nodef = customer_scripts[numberf]
	board_node.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	current_order = nodef.current_order
	if current_order == []:
		board_node.hide()
	else:
		board_node.show()
		match current_order[1]:
			1: 
				onef.play("cheese")
			2: 
				onef.play("beef")
			3: 
				onef.play("chicken")
			4: 
				onef.play("bacon")
			5: 
				onef.play("little_corn")
			0: 
				onef.hide()
		match current_order[2]:
			1: 
				twof.play("cheese")
			2: 
				twof.play("beef")
			3: 
				twof.play("chicken")
			4: 
				twof.play("bacon")
			5: 
				twof.play("little_corn")
			0: 
				twof.hide()
		match current_order[3]:
			1: 
				threef.play("cheese")
			2: 
				threef.play("beef")
			3: 
				threef.play("chicken")
			4: 
				threef.play("bacon")
			5: 
				threef.play("little_corn")
			0: 
				threef.hide()
		if current_order.size()==3:
			match current_order[4]:
				1: 
					fourf.play("cheese")
				2: 
					fourf.play("beef")
				3: 
					fourf.play("chicken")
				4: 
					fourf.play("bacon")
				5: 
					fourf.play("little_corn")
				0:
					fourf.hide()



func _input(event: InputEvent) -> void:
	if not visible:
		return
	
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
			
			screen_overlay.position = position * bounding_sprite.scale
	elif event is InputEventKey:
		if event.is_action_pressed("section_1"):
			position = section_positions[0]
		elif event.is_action_pressed("section_2"):
			position = section_positions[1]
		elif event.is_action_pressed("section_3"):
			position = section_positions[2]




func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
