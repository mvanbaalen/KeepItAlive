extends Node

const per_month:float = float(1)/12

#These should probably go in a constants thing but meh
enum SIZE {SMALL, MEDIUM, LARGE}
enum TYPE {PLANT, ANIMAL}

onready var creature_class = preload("res://scripts/creature.gd")
onready var life = []
onready var planet_name = ""
onready var month = 1
onready var sunlight = 140000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func new_planet():
	planet_name = Helpers.generate_name()
	life = []
	var first_creature = new_random_creature()
	first_creature.type = TYPE.PLANT
	var second_creature = new_random_creature()
	second_creature.set_properties(first_creature.size, TYPE.ANIMAL, TYPE.PLANT)
	var final_creature = new_random_creature()
	if final_creature.type == TYPE.ANIMAL:
		final_creature.eats = TYPE.ANIMAL
		final_creature.size = first_creature.size
		
func creature_died(creature):
	life.erase(creature)
	
func new_random_creature():
	var new_creature = creature_class.new()
	new_creature.randomize_properties()
	new_creature.number = randi() % 2000 + 9000
	life.append(new_creature)
	return new_creature
	
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
	new_creature.number = randi() % 20 + 90
	life.append(new_creature)
	return new_creature
	

func advance_one_month():
	var small_plants_required=0; var medium_plants_required=0; var large_plants_required=0;
	
	
	month += 1
	var counts = perform_deaths_and_births()

	# Now they need to eat...
	# Carnivores first I guess
	# Yeah there's ordering issues, so shoot me
	for predator in life:
		if predator.type == TYPE.ANIMAL:
			for prey in life:
				if prey != predator:
					if prey.size == predator.size && prey.type == predator.eats:
						prey.number -= predator.number / counts[[predator.size, prey.type]]
				
				
		# O(n^2) oh yeah baby
		
func perform_deaths_and_births():
	# Remove and add creatures roughly based on rates
	# Yes I made up all of these numbers randomly
	var counts = {
		[SIZE.SMALL, TYPE.PLANT]: 0,
		[SIZE.MEDIUM, TYPE.PLANT]: 0,
		[SIZE.LARGE, TYPE.PLANT]: 0,
		[SIZE.SMALL, TYPE.ANIMAL]: 0,
		[SIZE.MEDIUM, TYPE.ANIMAL]: 0,
		[SIZE.LARGE, TYPE.ANIMAL]: 0,
		
	}
	for creature in life:
		if creature.type == TYPE.PLANT:
			if creature.size == SIZE.SMALL:
				creature.number -= int(creature.number * per_month)
				creature.number += int(creature.number * 2 * per_month)
				counts[[SIZE.SMALL, TYPE.PLANT]] += 1
			elif creature.size == SIZE.MEDIUM:
				creature.number -= int(creature.number * 1/10 * per_month)
				creature.number += int(creature.number * 1/2 * per_month)
				counts[[SIZE.MEDIUM, TYPE.PLANT]] += 1
			elif creature.size == SIZE.LARGE:
				creature.number -= int(creature.number * 1/100 * per_month)
				creature.number += int(creature.number * 1/10 * per_month)
				counts[[SIZE.LARGE, TYPE.PLANT]] += 1
		else:
			if creature.eats == TYPE.PLANT:
				if creature.size == SIZE.SMALL:
					creature.number -= int(creature.number * per_month)
					creature.number += int(creature.number * 2 * per_month)
					counts[[SIZE.SMALL, TYPE.ANIMAL]] += 1
				elif creature.size == SIZE.MEDIUM:
					creature.number -= int(creature.number * 1/4 * per_month)
					creature.number += int(creature.number * per_month)
					counts[[SIZE.MEDIUM, TYPE.ANIMAL]] += 1
				elif creature.size == SIZE.LARGE:
					creature.number -= int(creature.number * 1/10 * per_month)
					creature.number += int(creature.number * 1/4 * per_month)
					counts[[SIZE.LARGE, TYPE.ANIMAL]] += 1
			else:
				#Same for now
				if creature.size == SIZE.SMALL:
					creature.number -= int(creature.number * per_month)
					creature.number += int(creature.number * 4 * per_month)
				elif creature.size == SIZE.MEDIUM:
					creature.number -= int(creature.number * 1/4 * per_month)
					creature.number += int(creature.number * per_month)
				elif creature.size == SIZE.LARGE:
					creature.number -= int(creature.number * 1/10 * per_month)
					creature.number += int(creature.number * 1/4 * per_month)
	return counts
