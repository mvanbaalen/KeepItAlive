extends Control

const details_scene = preload("res://scenes/CreatureDetails.tscn")

var best_streak = 0
var last_change = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	for creature in Planet.life:
		add_new_creature_details(creature)
	$Panel2/PlanetName.text += Planet.planet_name
	
func advance_one_year():
	Planet.advance_one_month()


func add_new_creature_details(creature):
	var details = details_scene.instance()
	details.get_node("Name").text = creature.name
	details.get_node("Count").text = str(creature.number)
	details.set_referent(creature)
	$Panel/VBoxContainer/Creatures.add_child(details)

func _on_AdvanceButton_pressed():
	advance_one_year()
	$Panel3/YearLabel.text = "Month " + str(Planet.month) #signal


func _on_introduce_button_pressed():
	var size_text = $CreatePanel/Sizes.get_item_text($CreatePanel/Sizes.get_selected_items()[0])
	var type_text = $CreatePanel/Types.get_item_text($CreatePanel/Types.get_selected_items()[0])
	var new_creature = Planet.new_creature_from_dialog(size_text, type_text)
	add_new_creature_details(new_creature)
	last_change = Planet.month


func _on_month_timer_timeout():
	advance_one_year()
	$Panel3/YearLabel.text = "Month " + str(Planet.month) #signal
	if Planet.month - last_change > best_streak:
		best_streak = Planet.month - last_change
	$Panel3/StreakLabel.text = "Streak " + str(Planet.month - last_change)
	$Panel3/BestLabel.text = "Best " + str(best_streak)
	
