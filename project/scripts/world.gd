extends Node

#These should probably go in a constants thing but meh
enum SIZE {SMALL, MEDIUM, LARGE}
enum TYPE {PLANT, ANIMAL}

onready var creature_class = preload("res://scripts/creature.gd")
onready var life = []
onready var planet_name = ""
onready var year = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func new_planet():
	planet_name = Helpers.generate_name()
	life = []
	for _i in range(3):
		new_random_creature()
	
func new_random_creature():
	var new_creature = creature_class.new()
	new_creature.randomize_properties()
	life.append(new_creature)
	
func new_creature_from_dialog(new_size, new_type):
	var final_size; var final_type; var final_diet
	#Oh you know we love this kind of logic...
	if new_size == "Small":
		final_size = SIZE.SMALL
	elif new_size == "Medium":
		final_size = SIZE.MEDIUM
	else:
		final_size = SIZE.LARGE
	if new_type == "Plant":
		final_type = TYPE.PLANT
		final_diet = null
	elif new_type == "Herbivore":
		final_type = TYPE.ANIMAL
		final_diet = TYPE.PLANT
	else:
		final_type = TYPE.ANIMAL
		final_diet = TYPE.ANIMAL
		
	var new_creature = creature_class.new()
	new_creature.set_properties(final_size, final_type, final_diet)
	life.append(new_creature)
	return new_creature
	

#func advance_one_month():
#	# First Pass : Just Kill Off and Grow Animals and Plants
#	for creature in life:
#		if creature.size == SIZE.SMALL:
#
