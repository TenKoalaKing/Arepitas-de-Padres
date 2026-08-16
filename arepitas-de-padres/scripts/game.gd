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

var customer_scripts := [$msdfksodkfp, $CustomerScreen/Node/customer, $CustomerScreen/Node/customer2, $CustomerScreen/Node/customer3, $CustomerScreen/Node/customer4, $CustomerScreen/Node/customer5, $CustomerScreen/Node/customer6, $CustomerScreen/Node/customer7, $CustomerScreen/Node/customer8]
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
func _ready() -> void:
	start_menu.show()
	customer_screen.hide()
	interior.hide()
	start_button.pressed.connect(go_to_customer_screen)
	start_button.pressed.connect(add_order)
	shop_button.pressed.connect(go_to_shop)
	
	start_menu.custom_minimum_size = get_viewport_rect().size
	screen_overlay.custom_minimum_size = get_viewport_rect().size
	
	screen_overlay.color = Color(0, 0, 0, 0) #A young married couple is very excited to be come parents. They are so into it that they are getting info everywhere they can; internet, books, classes, other parents. As they due date gets closer they have a name picked out for both genders (of course they want the surprise) and the room is all decorated in a neutral color. Finally, the big day arrives. The parents to be are in the delivery room and the husband is rushing out to the waiting room to update the just as excited family. With one final push out comes their baby. The doc and nurses do their thing and the doc asks if the dad wants to cut the umbilical cord. He of course does. But, before handing the parents their new baby the doc starts swinging the baby around by its umbilical cord. Faster and faster, blood starts flying everywhere. The parents are screaming. Then, the doc just chucks the baby right out the door like a bowling ball. The parents continue screaming at the doc and he just calmly looks over at them and says, "Don't worry, it was dead when it came out."




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
	#character_handed_to = customer_orders.size() + previous_order_count #FIXIFIXIIFIXIIFIX
	if character_handed_to != 0:
		#344.0, 425.0
		match next_customer_served_in_line:
			1:
				while $CustomerScreen/Node/customer.position.x > 344 and $CustomerScreen/Node/customer.position.y > 425:
					if $CustomerScreen/Node/customer.position.x > 344:
						$CustomerScreen/Node/customer.position.x -= 3*randf()
					if $CustomerScreen/Node/customer.position.y > 425:
						$CustomerScreen/Node/customer.position.y -= 1.5*randf()
					await wait_time(0.015)
					ready_to_order = 1
			2:
				while $CustomerScreen/Node/customer2.position.x > 344 and $CustomerScreen/Node/customer.position.y > 425:
					if $CustomerScreen/Node/customer2.position.x > 344:
						$CustomerScreen/Node/customer2.position.x -= 3*randf()
					if $CustomerScreen/Node/customer2.position.y > 425:
						$CustomerScreen/Node/customer2.position.y -= 1.5*randf()
					await wait_time(0.015)
					ready_to_order = 1
			3:
				while $CustomerScreen/Node/customer3.position.x > 344 and $CustomerScreen/Node/customer.position.y > 425:
					if $CustomerScreen/Node/customer3.position.x > 344:
						$CustomerScreen/Node/customer3.position.x -= 3*randf()
					if $CustomerScreen/Node/customer3.position.y > 425:
						$CustomerScreen/Node/customer3.position.y -= 1.5*randf()
					await wait_time(0.015)
					ready_to_order = 1
			4:
				while $CustomerScreen/Node/customer4.position.x > 344 and $CustomerScreen/Node/customer.position.y > 425:
					if $CustomerScreen/Node/customer4.position.x > 344:
						$CustomerScreen/Node/customer4.position.x -= 3*randf()
					if $CustomerScreen/Node/customer4.position.y > 425:
						$CustomerScreen/Node/customer4.position.y -= 1.5*randf()
					await wait_time(0.015)
					ready_to_order = 1
			5:
				while $CustomerScreen/Node/customer5.position.x > 344 and $CustomerScreen/Node/customer.position.y > 425:
					if $CustomerScreen/Node/customer5.position.x > 344:
						$CustomerScreen/Node/customer5.position.x -= 3*randf()
					if $CustomerScreen/Node/customer5.position.y > 425:
						$CustomerScreen/Node/customer5.position.y -= 1.5*randf()
					await wait_time(0.015)
					ready_to_order = 1
			6:
				while $CustomerScreen/Node/customer6.position.x > 344 and $CustomerScreen/Node/customer.position.y > 425:
					if $CustomerScreen/Node/customer6.position.x > 344:
						$CustomerScreen/Node/customer6.position.x -= 3*randf()
					if $CustomerScreen/Node/customer6.position.y > 425:
						$CustomerScreen/Node/customer6.position.y -= 1.5*randf()
					await wait_time(0.015)
					ready_to_order = 1
			7:
				while $CustomerScreen/Node/customer7.position.x > 344 and $CustomerScreen/Node/customer.position.y > 425:
					if $CustomerScreen/Node/customer7.position.x > 344:
						$CustomerScreen/Node/customer7.position.x -= 3*randf()
					if $CustomerScreen/Node/customer7.position.y > 425:
						$CustomerScreen/Node/customer7.position.y -= 1.5*randf()
					await wait_time(0.015)
					ready_to_order = 1
			8:
				while $CustomerScreen/Node/customer8.position.x > 344 and $CustomerScreen/Node/customer.position.y > 425:
					if $CustomerScreen/Node/customer8.position.x > 344:
						$CustomerScreen/Node/customer8.position.x -= 3*randf()
					if $CustomerScreen/Node/customer8.position.y > 425:
						$CustomerScreen/Node/customer8.position.y -= 1.5*randf()
					await wait_time(0.015)
					ready_to_order = 1
			
		await wait_time(1)
		character_handed_to = 0
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
