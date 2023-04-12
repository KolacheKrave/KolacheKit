extends Control

@export var kolacheList = Array([])
@onready var labelSectionBox = $VBoxContainer/HBoxContainer/VBoxContainer 
@onready var labelSectionScene = load("res://LabelProgramParts/LabelSection.tscn")
@onready var labelDividerScene = load("res://LabelProgramParts/LabelDivider.tscn")
@onready var viewportView = $SubViewport
@onready var numpad = $"%NumPad"
@onready var numButt = load("res://GenericScenes/IndexNumpadButton.tscn")
@onready var listToPrint = $"%LabelList"
var indexNumber = 1
# var printHandlerScene = load("res://LabelProgramParts/PrintHandler.tscn")
var saveOnClose = true
var DevNum = 200
var dir = OS.get_user_data_dir()
# Called when the node enters the scene tree for the first time.
func _ready():
	load_data()
	create_label_buttons()
		
	dir = dir + "/kolache_krave_print.png"
	
	for x in 9:
		var numInst = numButt.instantiate()
		numInst.text = str(x + 1)
		numpad.add_child(numInst)
	
	var numInst = numButt.instantiate()
	numpad.add_child(MarginContainer.new())
	numpad.add_child(numInst)
	
	for x in numpad.get_children():
		if x is Button:
			x.connect("pressed",Callable(self,"numpad_key_entered").bind(x.text))
			pass
		else:
			pass
		pass
	
	$SubViewport.size.x = 200
	$SubViewport.size.y = 200
	pass # Replace with function body.


func create_label_buttons():
	for child in $VBoxContainer/HBoxContainer/VBoxContainer.get_children():
		child.queue_free()
	var sectionIndex = Array([])
	var y = 0
	
	for x in kolacheList:
		if ':' in x:
			sectionIndex.append(y)
		y = y+1
	sectionIndex.append(kolacheList.size())
	
	for x in sectionIndex.size():
		# was x + 1 before (below)
		if x + 1 == sectionIndex.size():
			break
		var sectionInstance = labelSectionScene.instantiate()
		var dividerInstance = labelDividerScene.instantiate()
		var currentSectionTitle = kolacheList[sectionIndex[x]]
		var indexMin = sectionIndex[x] + 1
		# Did say - 1 below
		var indexMax = sectionIndex[x+1]
		var currentKolacheArray = kolacheList.slice(indexMin,indexMax)
		dividerInstance.init(currentSectionTitle)
		labelSectionBox.add_child(dividerInstance)
		sectionInstance.init(currentKolacheArray)
		labelSectionBox.add_child(sectionInstance)
		
	
#func test():
#	var labelArray = ""
#	var x
	

func save_data(content):
	var file = FileAccess.open("user://Kolache_List.txt", FileAccess.WRITE)
	content = str(content)
	content = content.replace(', ','\n')
	content = content.replace('[',"")
	content = content.replace(']',"")
	file.store_string(content)
	file.close()
	
	pass

func load_data():
	var file = FileAccess.open("user://Kolache_List.txt", FileAccess.READ)
	var content = file.get_as_text()
	content = content.replacen('"','')
	content = content.replacen('\\','')
	file.close()
	convert_text_to_array(content)
	$QuickEditPopup/PanelContainer/VBoxContainer/TextEdit.text = content

func convert_text_to_array(input):
	var plainText = input
	var kolacheArray = plainText.split('\n')
	kolacheList = Array(kolacheArray)
	create_label_buttons()

func _on_TopBar_quick_edit_start():
	$QuickEditPopup.popup()
	pass # Replace with function body.


func _on_QuickEditPopup_popup_hide():
	if saveOnClose == false:
		load_data()
	else:
		convert_text_to_array($QuickEditPopup/PanelContainer/VBoxContainer/TextEdit.text)
		save_data(kolacheList) # Replace with function body.
	saveOnClose = true

func _on_CancelButton_pressed():
	saveOnClose = false
	$QuickEditPopup.hide()
	pass # Replace with function body.


func go_print():
	var list = $"%LabelList"
	var itemCount = list.get_item_count()
	var loopAmount = int(ceil(float(itemCount)/2))
	var stickers = $SubViewport/StickersToPrint
	
	for x in loopAmount:
		if itemCount == 1:
			list.add_item("")
			pass
		stickers.redraw(list.get_item_text(0),1)
		list.remove_item(0)
		itemCount = itemCount - 1
		stickers.redraw(list.get_item_text(0),2)
		list.remove_item(0)
		itemCount = itemCount - 1
		await get_tree().create_timer(0.035).timeout
		#Said .get_data() below
		var img = viewportView.get_viewport().get_texture().get_image()
		#img.flip_x()
#		var picPath = "user://kolache_krave_print.png"
		img.save_png("user://kolache_krave_print.png")
		
		if OS.get_name() == "Windows":
#			get_tree().call_group("print_manage", "MadeToPrint")
			pass
		else:
			var DevText = "media=Custom." + "1" + "x" + "1in"
			OS.execute("lpr", ["-o", DevText, dir])
			pass
		
	$"%LabelListBar"._on_Clear_pressed()
	pass

func _on_PrintButton_pressed():
	go_print()
	return
	

func play_click_sound():
	$ClickSound.pitch_scale = randf_range(0.8,1.2)
	$ClickSound.play()


func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://Main.tscn")
	pass # Replace with function body.

func _on_IndexToggle_toggled(button_pressed):
	if button_pressed == true:
		$"%TabContainer".set_current_tab(1)
	else:
		$"%TabContainer".set_current_tab(0)
		numpad_key_entered(1)
	pass # Replace with function body.

func numpad_key_entered(number):
	indexNumber = number
	get_tree().call_group("index_number_group","change_toggle",number)
	pass

func a_bunch_added(passedName, amount):
	var previousIndexNumber = indexNumber
	indexNumber = amount
	_label_button_pressed(passedName)
	get_tree().call_group("label_buttons","add_to_labled_amount",passedName,indexNumber)
	indexNumber = previousIndexNumber
	pass

func open_add_a_bunch(passedName):
	$AddABunch.pass_name(passedName)
	$AddABunch.popup()
	pass

func _label_button_pressed(itemToAdd):
	for x in int(indexNumber):
		listToPrint.add_item(itemToAdd)
	var newSelect = listToPrint.get_item_count()
	listToPrint.select(newSelect - 1)
	listToPrint.ensure_current_is_visible()
	play_click_sound()
	$"%PrintButton".text = "Print x" + str(listToPrint.get_item_count())
	pass
	

func a_bunch_deleted(amount):
	$"%LabelListBar".delete_items(amount)
