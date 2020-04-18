extends Node

onready var creature_class = preload("res://scripts/creature.gd")
onready var life = []
onready var planet_name = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func new_planet():
	planet_name = Helpers.generate_name()
	life.append(new_random_creature())
	life.append(new_random_creature())
	life.append(new_random_creature())
	
func new_random_creature():
	return creature_class.new()
