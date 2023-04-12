extends Popup

@export var UUID = 0
@onready var rootProgram = get_node("/root/TimerProgram")
var sub_title = ""
var locationPresets = Array([])
@onready var list = $Panel/VBoxContainer/Presets
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	load_from_file()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Title_text_entered(new_text):
	sub_title = new_text
	$Panel/VBoxContainer/Title.release_focus()
	pass # Replace with function body.


func _on_Save_pressed():
	sub_title = $Panel/VBoxContainer/Title.text
	if sub_title == "":
		var selected = list.get_selected_items()
		if Array(selected) == Array([]):
			return
		locationPresets.remove(selected[0])
		refresh_location_presets()
		return
	if locationPresets == null:
		locationPresets = [sub_title]
		refresh_location_presets()
		return
	locationPresets.append(sub_title)
	refresh_location_presets()
	
	pass # Replace with function body.


func _on_LocationSet_popup_hide():
	sub_title = $Panel/VBoxContainer/Title.text
	rootProgram.new_location_set(UUID,sub_title)
	pass # Replace with function body.


func _on_LocationSet_about_to_show():
	$Panel/VBoxContainer/Title.text = ""
	$Panel/VBoxContainer/Presets.deselect_all()
	pass # Replace with function body.


func _on_Presets_item_selected(index):
	sub_title = list.get_item_text(index)
	$Panel/VBoxContainer/Title.text = sub_title
	pass # Replace with function body.

func refresh_location_presets():
	list.clear()
	if locationPresets == null:
		return
	for x in locationPresets:
		list.add_item(x)
	save_to_file()

func save_to_file():
	var file = FileAccess.open("user://Location_Presets.txt", FileAccess.WRITE)
	file.store_var(locationPresets)
	file.close()

func load_from_file():
	var file = FileAccess.open("user://Location_Presets.txt", FileAccess.READ)
	locationPresets = file.get_var()
	file.close()
	refresh_location_presets()
