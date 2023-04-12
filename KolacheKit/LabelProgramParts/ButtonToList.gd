extends HBoxContainer
@onready var list = $"%LabelList"
@onready var buttons = get_node("VBoxContainer/LabelSection")
@onready var rootProgram = get_node("/root/LabelProgram/")
@onready var printButton = $"%PrintButton"

func _ready():
	$"%TabContainer".set_tab_title(0, "Regular")
	$"%TabContainer".set_tab_title(1, "Index")
	pass # Replace with function body.


func _label_button_pressed(itemToAdd):
	var amount = rootProgram.indexNumber
	for x in int(amount):
		list.add_item(itemToAdd)
	var newSelect = list.get_item_count()
	list.select(newSelect - 1)
	list.ensure_current_is_visible()
	rootProgram.play_click_sound()
	printButton.text = "Print x" + str(list.get_item_count())
	pass
