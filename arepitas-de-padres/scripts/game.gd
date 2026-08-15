class_name Game
extends Node2D

const MAX_CUSTOMER_COUNT: int = 4
const MIN_CUSTOMER_COOL_DOWN_SECS: float = 20
const MAX_CUSTOMER_COOL_DOWN_SECS: float = 50

@export var customer_screen: Sprite2D
@export var interior: Sprite2D

@export var interior_camera: Camera2D

@export var shop_button: Button

var delayed_customers: Array[Order]
var customer_orders: Array[Order]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	customer_screen.show()
	interior.hide()
	shop_button.pressed.connect(go_to_shop)
	add_order()


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("exit"):
			if interior.visible:
				go_to_customer_screen()


func add_order() -> void:
	if customer_orders.size() == MAX_CUSTOMER_COUNT:
		delayed_customers.append(Order.new(1))
	else:
		customer_orders.append(Order.new(1))
	
	var cool_down_secs = randf_range(MIN_CUSTOMER_COOL_DOWN_SECS, MAX_CUSTOMER_COOL_DOWN_SECS)
	var timer: SceneTreeTimer = get_tree().create_timer(cool_down_secs)
	timer.timeout.connect(add_order)
	print_orders()


func print_orders() -> void:
	print("Orders:")
	for customer_order in customer_orders:
		print("Order: %s arepas" % customer_order.arepa_count)
	print("")


func go_to_shop() -> void:
	customer_screen.hide()
	interior.show()
	interior_camera.enabled = true


func go_to_customer_screen() -> void:
	customer_screen.show()
	interior.hide()
	interior_camera.enabled = false
