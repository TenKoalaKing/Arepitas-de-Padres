class_name Game
extends Node2D

const MAX_CUSTOMER_COUNT: int = 4
const MIN_CUSTOMER_COOL_DOWN_SECS: float = 20
const MAX_CUSTOMER_COOL_DOWN_SECS: float = 50
const FADE_DURATION_SECS: float = 0.5

@export var start_menu: Control
@export var customer_screen: Sprite2D
@export var interior: Sprite2D

@export var start_button: Button
@export var shop_button: Button
@export var interior_camera: ScrollCamera

@export var screen_overlay: ColorRect

var delayed_customers: Array[Order]
var customer_orders: Array[Order]
#customer section!!!!!!!!!!!!
var character_type := 0
var character_handed_to := 0
var percent_cooked_furthest_from_100 := 0 # ADD BEFORE DEMO!
var day_finished := 0 #true if equals to 1
var start = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_menu.show()
	customer_screen.hide()
	interior.hide()
	$CustomerScreen/Node/customer2.hide()
	$CustomerScreen/Node/customer3.hide()
	$CustomerScreen/Node/customer4.hide()
	$CustomerScreen/Node/customer5.hide()
	$CustomerScreen/Node/customer6.hide()
	$CustomerScreen/Node/customer7.hide()
	$CustomerScreen/Node/customer8.hide()
	
	start_button.pressed.connect(go_to_customer_screen)
	start_button.pressed.connect(add_order)
	shop_button.pressed.connect(go_to_shop)
	
	start_menu.custom_minimum_size = get_viewport_rect().size
	screen_overlay.custom_minimum_size = get_viewport_rect().size
	
	screen_overlay.color = Color(0, 0, 0, 0)


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("exit"):
			if interior.visible:
				go_to_customer_screen()


func add_order() -> void: #character_handed_to
	if start == 1:
		start = 0
		customer_orders.append(Order.new(1))
	if customer_orders.size() == MAX_CUSTOMER_COUNT:
		delayed_customers.append(Order.new(1))
	else:
		customer_orders.append(Order.new(1))
	character_handed_to = customer_orders.size()
	if character_handed_to != 0:
		#344.0, 425.0
		while $CustomerScreen/Node/customer.position.x > 344 and $CustomerScreen/Node/customer.position.y > 425:
			if $CustomerScreen/Node/customer.position.x > 344:
				$CustomerScreen/Node/customer.position.x -= 3*randf()
			if $CustomerScreen/Node/customer.position.y > 425:
				$CustomerScreen/Node/customer.position.y -= 1.5*randf()
			await wait_time(0.015)

			
		await wait_time(1)
		character_handed_to = 0
	var cool_down_secs = randf_range(MIN_CUSTOMER_COOL_DOWN_SECS, MAX_CUSTOMER_COOL_DOWN_SECS)
	var timer: SceneTreeTimer = get_tree().create_timer(cool_down_secs)
	if day_finished != 1:
		timer.timeout.connect(add_order)
		print_orders()


func print_orders() -> void:
	print("Orders:")
	for customer_order in customer_orders:
		print("Order: %s arepas" % customer_order.arepa_count)
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
func _process(_delta: float) -> void:
	if customer_screen.visible == true:
		$CustomerScreen/Node/customer.hide()

func start_scene_transition() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(screen_overlay, "color", Color(0, 0, 0, 1), FADE_DURATION_SECS / 2)
	await tween.step_finished


func finish_scene_transition() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(screen_overlay, "color", Color(0, 0, 0, 0), FADE_DURATION_SECS / 2)





func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
