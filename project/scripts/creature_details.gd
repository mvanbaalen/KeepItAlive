extends HBoxContainer

var referent

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_referent(creature):
	referent = creature
	creature.connect("updated", self, "update_stats")
	
func update_stats():
	$Count.text = str(referent.number)
