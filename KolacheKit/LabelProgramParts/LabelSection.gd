extends ColorRect
@onready var loadedButton = load("res://LabelProgramParts/LabelButton.tscn")
var lables = Array([])
#@onready var columns = $Control/GridContainer.columns

func init(importedLabels):
	lables = importedLabels
	pass


func _ready():
	var y = 0
	for x in lables:
		y = y+1
		var instancedButton = loadedButton.instantiate()
		instancedButton.init(x)
		$Control/GridContainer.add_child(instancedButton)
	await get_tree().create_timer(0.01).timeout
	self.custom_minimum_size.y = $Control/GridContainer.get_line_count() * 75 + 20
	self.size = self.custom_minimum_size
	#(ceil(y/columns) * 75) + 100
