extends AnimatedSprite2D
@export var game_path:NodePath
@onready var game_script = get_node(game_path)
@export var character_num := 0
var rng = RandomNumberGenerator.new()
var next_character := 0
var percent_differential := 20 # change to 0 after finished with character select script!
var character_type  := 0
var character_handed_to := 0
var character_handed_to_finished := 0
var percent_cooked_furthest_from_100 := 0
var character_not_active := 1
var interact_local := 0
var dissatissfied_high_time := 80
var satissfied_high_time := 40
var very_satissfied_high_time := 20
var extremely_satisfied_high_time := 12
var dissastissfaction := 0.0 #maintaining level of dissatisfaction
var waiting := 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#self.hide()
	pass


func _process(_delta: float) -> void:
	next_character = character_num
	if character_num == next_character and character_not_active == 1:
		self.show()
		character_type = game_script.character_type
		character_not_active = 0
		play("hungry") #then teleport it to game and make it walk to the stand
		#uncomment after demo
	#if Input.is_action_pressed("interact"):
	#	interact_local = 1
	#	hungry_impatient_timer()
	character_handed_to = game_script.character_handed_to
	if character_handed_to == character_num and character_handed_to_finished != 1: # add one sec delay before deleting this value from game script
		character_handed_to_finished = 1
		percent_cooked_furthest_from_100 = game_script.percent_cooked_furthest_from_100
		character_not_active = 1
		rng.randomize()
		#random_number = rng.randi_range(1, 10) do later and matching with manager and other charachters
		if waiting >= dissatissfied_high_time:
			dissastissfaction += 2
		elif waiting >= satissfied_high_time:
			dissastissfaction += 1
		elif waiting >= very_satissfied_high_time:
			dissastissfaction += 0.5
		if percent_differential > percent_cooked_furthest_from_100 and percent_differential < 2 * percent_cooked_furthest_from_100:
			dissastissfaction += 1
		if percent_differential > 2 * percent_cooked_furthest_from_100:
			dissastissfaction += 2
		match dissastissfaction:
			var n when n <= 1:
				play("extremely_satissfied")
			var n when n <= 2 and n > 1:
				play("customer_very_satisfied")
			var n when n <= 3 and n > 2:
				play("customer_satisfied")
			var n when n > 3:
				play("dissatissfied")
		dissastissfaction = 0
		self.hide()
		
		
		


func hungry_impatient_timer():
	interact_local = 0
	await wait_time(60)
	if get_animation() == "hungry":
		play("hungry_impatient")


func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
