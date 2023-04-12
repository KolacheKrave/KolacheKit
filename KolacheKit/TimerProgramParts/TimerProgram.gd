extends ColorRect
@onready var gridGetter = $VBoxContainer/GridContainer
var allStopped = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_on_NewButton_pressed()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NewButton_pressed():
	var timeBoxLoad = load("res://TimerProgramParts/TimerBox.tscn")
	var timeInstance = timeBoxLoad.instantiate()
	timeInstance.init(randi())
	gridGetter.add_child(timeInstance)
	pass # Replace with function body.

func location_popup_called(UUID):
	$LocationSet.UUID = UUID
	$LocationSet.popup()
	pass

func timer_popup_called(UUID, timerTitle):
	$TimerSet.UUID = UUID
	$TimerSet/Panel/HBoxContainer/SaveLoadInput/Title.text = timerTitle
	$TimerSet.popup()
	$TimerSet/Panel/HBoxContainer/SaveLoadInput/Presets.deselect_all()
	
	pass
	
func timer_gone_off():
	if $AlarmIntro.playing == false && $AlarmLoop.playing == false:
		$AlarmIntro.play()

func alarm_stopped():
	await get_tree().create_timer(0.001).timeout
	get_tree().call_group("timer_boxes", "still_going_check")
	if allStopped == true:
		$AlarmIntro.stop()
		$AlarmLoop.stop()
	allStopped = true
	pass

func not_stopped():
	allStopped = false
	pass


func _on_AlarmIntro_finished():
	await get_tree().create_timer(0.001).timeout
	get_tree().call_group("timer_boxes", "still_going_check")
	if allStopped == false:
		$AlarmLoop.play()
	allStopped = true
	pass # Replace with function body.

func new_timer_set(UUID,intTime,title):
	get_tree().call_group("timer_boxes", "set_time", UUID, intTime, title)
	pass

func new_location_set(UUID, location):
	get_tree().call_group("timer_boxes", "set_location", UUID, location)
	pass

func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://Main.tscn")
	pass # Replace with function body.

 # Replace with function body.
