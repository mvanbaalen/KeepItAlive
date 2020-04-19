extends Control

const details_scene = preload("res://scenes/CreatureDetails.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for creature in Planet.life:
		var details = details_scene.instance()
		details.get_node("Name").text = creature.name
		details.get_node("Count").text = str(creature.number)
		details.set_referent(creature)
		$Panel/VBoxContainer/Creatures.add_child(details)
	$Panel2/PlanetName.text += Planet.planet_name
	
func advance_one_year():
	Planet.year += 1
	for creature in Planet.life:
		creature.number += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AdvanceButton_pressed():
	advance_one_year()
	$Panel3/YearLabel.text = "Year " + str(Planet.year)
	
