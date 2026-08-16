class_name ArepaData
extends RefCounted

enum Filling {
	NONE,
	CHEESE,
	BEEF,
	CHICKEN,
	BACON,
	CORN,
	FILLING_COUNT
}

var filling_1: Filling
var filling_2: Filling


func _init(p_filling_1: Filling = Filling.NONE, p_filling_2: Filling = Filling.NONE) -> void:
	filling_1 = p_filling_1
	filling_2 = p_filling_2


func randomize_fillings() -> void:
	filling_1 = randi_range(Filling.NONE, Filling.FILLING_COUNT - 1) as Filling
	filling_2 = randi_range(Filling.NONE, Filling.FILLING_COUNT - 1) as Filling
	if filling_1 == Filling.NONE:
		filling_1 = filling_2
		filling_2 = Filling.NONE
