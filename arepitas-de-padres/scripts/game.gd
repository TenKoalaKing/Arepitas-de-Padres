class_name Game
extends Node2D

const MAX_CUSTOMER_COUNT: int = 4
const MIN_CUSTOMER_COOL_DOWN_SECS: float = 20
const MAX_CUSTOMER_COOL_DOWN_SECS: float = 50

var delayed_customers: Array[Order]
var customer_orders: Array[Order]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_order()


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
