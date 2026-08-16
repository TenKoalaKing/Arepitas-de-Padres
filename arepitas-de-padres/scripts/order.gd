class_name Order
extends RefCounted

var arepas: Array[ArepaData]


func _init(p_arepas: Array[ArepaData] = []) -> void:
	arepas = p_arepas
