class_name Game
extends Node2D

const MAX_CUSTOMER_COUNT: int = 4
const NEW_CUSTOMER_COOL_DOWN_SECS: float = 30

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
	
	var timer: SceneTreeTimer = get_tree().create_timer(NEW_CUSTOMER_COOL_DOWN_SECS)
	timer.timeout.connect(add_order)
	print_orders()


func print_orders() -> void:
	print("Orders:")
	for customer_order in customer_orders:
		print("Order: %s arepas" % customer_order.arepa_count)
	print("")
