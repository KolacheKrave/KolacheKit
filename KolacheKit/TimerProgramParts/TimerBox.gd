extends Panel


@onready var waitTime = $Timer.wait_time
@onready var greyText = $NormalDisplay/TimeContainer/Panel/HBoxContainer/GreyedOut
@onready var timeText = $NormalDisplay/TimeContainer/Panel/HBoxContainer/NumberDisplay
@onready var closePopup = $NormalDisplay/HBoxContainer/MenuButton.get_popup()
@onready var rootProgram = get_node("/root/TimerProgram")
@onready var progressNode = $NormalDisplay/TimeContainer/Panel/Progress
var hour = 0
var minute = 0
var second = 0
var timeString = ""
var greyString = "00:00:00"
var usefulDigits = 0
var playPause = false
var UUID
var alarmFiring = false
var timerTitle = ""
var bbString = "[center][shake rate=20 level=8][b]%s[/b] at [b]%s[/b] \n is READY!"
var bbStringNoLoc = "[shake rate=20 level=8][center][b]%s[/b]\n is READY!"
var location


# Called when the node enters the scene tree for the first time.
func _ready():
	progressNode.tint_progress = Color.SKY_BLUE
	$Timer.connect("timeout",Callable(rootProgram,"timer_gone_off"))
	$AlarmDisplay/AlarmStop.connect("pressed",Callable(rootProgram,"alarm_stopped"))
	closePopup.connect("id_pressed",Callable(self,"close_popup_pressed"))
	$NormalDisplay/ControlContainer/LocationButton.connect("pressed",Callable(rootProgram,"location_popup_called").bind(UUID))
#	$NormalDisplay/TimeContainer/Panel/TextureButton.connect("pressed",Callable(rootProgram,"timer_popup_called").bind(UUID, timerTitle))
	pass # Replace with function body.


func _process(_delta):
	if playPause == true:
		timerDisplay()
	pass

func timerDisplay():
	var time = int($Timer.time_left)
	second = floor((time % 3600) % 60)
	minute = floor((time % 3600) / 60)
	hour = floor(time / 3600)
	timeString = str(hour+100).right(2) + ":" + str(minute+100).right(2) + ":" + str(second+100).right(2)
	usefulDigits = (hour * 1000000) + (minute * 1000) + second
	var usefulNum = str(usefulDigits).length()
	greyText.text = greyString.left(8 - usefulNum)
	timeText.text = timeString.right(usefulNum)
	progressNode.value = 100 * (1 - (time / waitTime))
	if time <= 60 && time > 10:
		progressNode.tint_progress = Color.SANDY_BROWN
	if time <= 10:
		progressNode.tint_progress = Color.SALMON


func _on_TextureButton_pressed():
	rootProgram.timer_popup_called(UUID,timerTitle)
	pass # Replace with function body.


# Replace with function body.


func _on_PlayPause_toggled(button_pressed):
	playPause = button_pressed
	if button_pressed == true:
		$Timer.start()
		$Timer.set_paused(false)
	else:
		$Timer.set_paused(true)
		$Timer.wait_time = $Timer.time_left
	pass # Replace with function body.

func init(id):
	UUID = id
	

func close_popup_pressed(id):
	queue_free()
	pass
# Replace with function body.


func _on_Timer_timeout():
	greyText.text = greyString
	timeText.text = ""
	playPause = false
	$AlarmDisplay/AlarmSwitchTime.start()
	if timerTitle == "":
		timerTitle = "Didn't bother to name it"
	if location == null:
		$AlarmDisplay/RichTextLabel.text = bbStringNoLoc % [timerTitle]
	else:
		$AlarmDisplay/RichTextLabel.text = bbString % [timerTitle, location]
	$AlarmDisplay.visible = true
	$NormalDisplay/TimeContainer/PlayPause.button_pressed = false
	pass # Replace with function body.


func _on_AlarmSwitchTime_timeout():
	$AlarmDisplay.color.r = abs(sin($AlarmDisplay.color.r * 3))
	pass # Replace with function body.


func _on_AlarmStop_pressed():
	$AlarmDisplay.visible = false
	$AlarmDisplay/AlarmSwitchTime.stop()
	progressNode.value = 0
	progressNode.tint_progress = Color.SKY_BLUE
	pass # Replace with function body.
	
func still_going_check():
	if $AlarmDisplay/AlarmSwitchTime.is_stopped() == false:
		rootProgram.not_stopped()
		pass


func _on_TimerTitle_text_entered(new_text):
	timerTitle = new_text
	$NormalDisplay/HBoxContainer/TimerTitle.release_focus()
	pass # Replace with function body.
	

func set_time(inUUID,intTime,title):
	if intTime == 0:
		return
	if UUID == inUUID:
		$Timer.stop()
		$NormalDisplay/HBoxContainer/TimerTitle.text = title
		timerTitle = title
		$Timer.wait_time = float(intTime)
		waitTime = float(intTime)
		$NormalDisplay/TimeContainer/PlayPause.button_pressed = false
		$NormalDisplay/TimeContainer/PlayPause.button_pressed = true
	pass
	
func set_location(inUUID,title):
	if UUID == inUUID:
		if title == "":
			location = null
			$NormalDisplay/ControlContainer/LocationButton.text = "Location >"
			return
		$NormalDisplay/ControlContainer/LocationButton.text = title
		location = title

