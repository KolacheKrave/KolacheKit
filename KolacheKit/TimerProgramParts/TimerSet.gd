extends Popup

@onready var line = $Panel/HBoxContainer/TimeInput/LineEdit
@onready var numpad = $Panel/HBoxContainer/TimeInput/Center/Numpad
@onready var numButt = load("res://GenericScenes/NumpadButton.tscn")
@onready var margin = MarginContainer.new()
@onready var rootProgram = get_node("/root/TimerProgram")
@export var UUID = 0
var emptyTimeString = "  :00"
var inputString = ""
var cancelPushed = false

var temp = [{"title":"Proofer","time":3600},{"title":"Bake","time":900}]
var timerPresets = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in 9:
		var numInst = numButt.instantiate()
		numInst.text = str(x + 1)
		numpad.add_child(numInst)
	
	var numInst = numButt.instantiate()
	numpad.add_child(MarginContainer.new())
	numpad.add_child(numInst)
	
	for x in numpad.get_children():
		if x is MarginContainer:
			pass
		else:
			x.connect("pressed",Callable(self,"numpad_key_entered").bind(x.text))
		pass
	load_from_file()
	pass # Replace with function body.

func numpad_key_entered(number):
	inputString = inputString + number
	var inputLength = inputString.length()
	if inputLength < 3:
		line.text = emptyTimeString.left(5 - inputLength) + inputString + " minutes"
	if inputLength == 3:
		line.text = inputString.left(1) + ":" + inputString.right(2)
	if inputLength == 4:
		line.text = inputString.left(2) + ":" + inputString.right(2)
	if inputLength >= 5:
		line.text = ""
		inputString = ""
		numpad_key_entered(number)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LineEdit_focus_entered():
	line.text = ""
	inputString = ""
	pass # Replace with function body.
# Replace with function body.


 # Replace with function body.


func _on_TimerSet_popup_hide():
	if cancelPushed == true:
		cancelPushed = false
		return
	if inputString == "":
		return
	var intTime = input_to_int()
	var title = $Panel/HBoxContainer/SaveLoadInput/Title.text
	rootProgram.new_timer_set(UUID,intTime,title)
	pass # Replace with function body.
	

func input_to_int():
	var time = int(inputString)
	var hours = int(str(time + 10000).substr(1,2))
	var minutes = int(str(time + 10000).substr(3,2))
	var intTime = (hours * 3600) + (minutes * 60)
	return intTime

func _on_SavePreset_pressed():
	var title = $Panel/HBoxContainer/SaveLoadInput/Title.text
	var list = $Panel/HBoxContainer/SaveLoadInput/Presets
	if int(inputString) == 0:
		if Array(list.get_selected_items()) == Array([]):
			return
		var selectedItem = list.get_selected_items()[0]
		timerPresets.remove(selectedItem)
		refresh_preset_list()
		return
	if title == "" || inputString == "":
		return
	var intTime = input_to_int()
	var output = {"title":title,"time":intTime}
	if Array(list.get_selected_items()) != Array([]):
		var selectedItem = list.get_selected_items()[0]
		timerPresets[selectedItem] = output
	else:
		if timerPresets == null:
			timerPresets = [output]
			refresh_preset_list()
			return
		timerPresets.append(output)
	refresh_preset_list()
	pass # Replace with function body.

func refresh_preset_list():
	save_to_file()
	var list = $Panel/HBoxContainer/SaveLoadInput/Presets
	list.clear()
	if timerPresets == null:
		return
	for x in timerPresets:
		list.add_item(x.title)
	$Panel/HBoxContainer/SaveLoadInput/Title.text = ""
	inputString = ""
	$Panel/HBoxContainer/TimeInput/LineEdit.text = ""
	pass


func _on_Presets_item_selected(index):
	$Panel/HBoxContainer/SaveLoadInput/Title.text = timerPresets[index].title
	var time = timerPresets[index].time
	var hour = floor(time / 3600)
	var minute = floor((time % 3600) / 60) + 100
	inputString = ""
	numpad_key_entered(str(hour) + str(minute).substr(1,2))
	pass # Replace with function body.


func _on_Button_pressed():
	cancelPushed = true
	hide()
	pass # Replace with function body.
	

func save_to_file():
	var file = FileAccess.open("user://Timer_Presets.txt", FileAccess.WRITE)
	file.store_var(timerPresets)
	file.close()
	pass

func load_from_file():
	var file = FileAccess.open("user://Timer_Presets.txt", FileAccess.READ)
	timerPresets = file.get_var()
	file.close()
	refresh_preset_list()


func _on_Title_text_entered(new_text):
	$Panel/HBoxContainer/SaveLoadInput/Title.release_focus()
	pass # Replace with function body.


func _on_about_to_popup():
	$Panel/HBoxContainer/TimeInput/LineEdit.text = ""
	pass # Replace with function body.
