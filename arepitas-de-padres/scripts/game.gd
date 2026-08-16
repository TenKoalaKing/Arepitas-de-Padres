class_name Game 
extends Node2D

const MAX_CUSTOMER_COUNT: int = 4
const MIN_CUSTOMER_COOL_DOWN_SECS: float = 20
const MAX_CUSTOMER_COOL_DOWN_SECS: float = 50
const FADE_DURATION_SECS: float = 0.5

const Filling = ArepaData.Filling

@export var start_menu: Control
@export var customer_screen: Sprite2D
@export var interior: Sprite2D

@export var start_button: Button
@export var shop_button: Button
@onready var interior_camera := $Interior/ScrollCamera #old: @export var interior_camera: ScrollCamera
@export var screen_overlay: ColorRect

@onready var customer_scripts := [null, $CustomerScreen/Node/customer, $CustomerScreen/Node/customer2, $CustomerScreen/Node/customer3, $CustomerScreen/Node/customer4, $CustomerScreen/Node/customer5, $CustomerScreen/Node/customer6, $CustomerScreen/Node/customer7, $CustomerScreen/Node/customer8]

#customer section!!!!!!!!!!!!
var character_type := 0
var character_handed_to := 0
var percent_cooked_furthest_from_100 := 0 # ADD BEFORE DEMO!
var day_finished := 0 #true if equals to 1
var start = 1
var next_customer_served_in_line := 0
var next_customer_to_be_served := 0
var customer_exit_var := 0
var ready_to_order := 0 # set to 0 in customer.gd
var previous_order_count := 0
var customer_orders: Array[Order] = []
var fillings_used_1 := Filling.NONE
var fillings_used_2 := Filling.NONE
var fillings_used_3 := Filling.NONE
var fillings_used_4 := Filling.NONE
var start_walking_twords_line := 0
var done_fundsaicnn := 0
func _ready() -> void:
	for i in range(8):
		customer_orders.push_back(Order.new([]))
	
	start_menu.show()
	customer_screen.hide()
	interior.hide()
	start_button.pressed.connect(go_to_customer_screen)
	start_button.pressed.connect(add_order)
	shop_button.pressed.connect(go_to_shop)
	
	start_menu.custom_minimum_size = get_viewport_rect().size
	screen_overlay.custom_minimum_size = get_viewport_rect().size
	
	screen_overlay.color = Color(0, 0, 0, 0)
func _process(_delta: float) -> void:
	print(next_customer_served_in_line)
	if next_customer_to_be_served == customer_scripts.find(customer_scripts[next_customer_to_be_served]) and done_fundsaicnn == 1:
		customer_served()
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("exit"):
			if interior.visible:
				go_to_customer_screen()


func add_order() -> void: #character_handed_to
	if start == 1:
		start = 0
		#customer_orders.append(Order.new(1))
	#else:
		#customer_orders.append(Order.new(1))
	next_customer_served_in_line = 0
	for i in range(8):
		if not customer_orders[i].arepas:
			next_customer_served_in_line = i + 1
			break
	
	var arepa_1 = ArepaData.new()
	var arepa_2 = ArepaData.new()
	
	arepa_1.randomize_fillings()
	arepa_2.randomize_fillings()
	
	fillings_used_1 = arepa_1.filling_1
	fillings_used_2 = arepa_1.filling_2
	fillings_used_3 = arepa_2.filling_1
	fillings_used_4 = arepa_2.filling_2
	
	if next_customer_served_in_line != 0:
		#344.0, 425.0
		var customer: AnimatedSprite2D = customer_scripts[next_customer_served_in_line]
		while customer.position.x > 344 and customer.position.y > 425:
			if customer.position.x > 344:
				customer.position.x -= 3*randf()
			if customer.position.y > 425:
				customer.position.y -= 1.5*randf()
			await wait_time(0.015)
			ready_to_order = 1
			
		await wait_time(1)
		
		customer_orders[next_customer_served_in_line - 1].arepas.push_back(arepa_1)
		customer_orders[next_customer_served_in_line - 1].arepas.push_back(arepa_2)
	
	var cool_down_secs = randf_range(MIN_CUSTOMER_COOL_DOWN_SECS, MAX_CUSTOMER_COOL_DOWN_SECS)
	var timer: SceneTreeTimer = get_tree().create_timer(cool_down_secs)
	if day_finished != 1:
		timer.timeout.connect(add_order)
		print_orders()


func print_orders() -> void:
	print("Orders:")
	#for customer_order in customer_orders:
	#	print("Order: %s arepas" % customer_order.arepa_count)
	print("")


func go_to_shop() -> void:
	await start_scene_transition()
	start_menu.hide()
	customer_screen.hide()
	$CustomerScreen/Node/customer.hide()
	interior.show()
	interior_camera.enabled = true
	screen_overlay.position = interior_camera.position * interior.position
	finish_scene_transition()


func go_to_customer_screen() -> void:
	await start_scene_transition()
	start_menu.hide()
	customer_screen.show()
	$CustomerScreen/Node/customer.show()
	interior.hide()
	interior_camera.enabled = false
	screen_overlay.position = Vector2(0, 0)
	finish_scene_transition()


func start_scene_transition() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(screen_overlay, "color", Color(0, 0, 0, 1), FADE_DURATION_SECS / 2)
	await tween.step_finished


func finish_scene_transition() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(screen_overlay, "color", Color(0, 0, 0, 0), FADE_DURATION_SECS / 2)

func order_taken():
	while customer_scripts[next_customer_served_in_line].position.x < 519 and customer_scripts[next_customer_served_in_line] < 553: # old x: 344, 425
		if customer_scripts[next_customer_served_in_line].position.x < 519:
			customer_scripts[next_customer_served_in_line].position.x += 3*randf()
		if  customer_scripts[next_customer_served_in_line].position.y < 553:
			print("space")
			customer_scripts[next_customer_served_in_line].position.y += 1.5*randf()
			next_customer_to_be_served = next_customer_served_in_line
		done_fundsaicnn = 1
func customer_served():
	while customer_scripts[next_customer_to_be_served].position.x > 344: # old x: 519, 553
		if customer_scripts[next_customer_to_be_served].position.x > 344: #REDUNDAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANT!!!!!!!!!!!!!!!!!!!!!!!!!!
			customer_scripts[next_customer_to_be_served].position.x -= 3*randf()
func customer_exit(): #customer_exit
	while customer_scripts[customer_exit_var].position.x < 519 and customer_scripts[customer_exit_var].position.y < 553: # old x: 344, 425
		if customer_scripts[customer_exit_var].position.x < 519:
			customer_scripts[customer_exit_var].position.x += 3*randf()
		if  customer_scripts[customer_exit_var].position.y < 553:
			print("space")
			customer_scripts[customer_exit_var].position.y += 1.5*randf()


func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
