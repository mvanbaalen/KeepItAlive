extends Node

enum SIZE {SMALL, MEDIUM, LARGE}
enum TYPE {PLANT, ANIMAL}

signal updated

var size
var type
var eats
var number setget set_number

func _init():
	size = SIZE.SMALL
	type = TYPE.PLANT
	eats = TYPE.PLANT
	number = randi() % 2000 + 9000
	name = Helpers.generate_name()


func set_number(new_value):
	number = new_value
	emit_signal("updated")
	
