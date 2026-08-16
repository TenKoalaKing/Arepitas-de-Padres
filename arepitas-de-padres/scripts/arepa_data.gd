class_name ArepaData
extends RefCounted

enum Filling {
	CHEESE,
	BEEF,
	CHICKEN,
	BACON,
	CORN,
	NONE
}

var filling_1: Filling
var filling_2: Filling


func _init(p_filling_1: Filling = Filling.NONE, p_filling_2: Filling = Filling.NONE) -> void:
	filling_1 = p_filling_1
	filling_2 = p_filling_2
