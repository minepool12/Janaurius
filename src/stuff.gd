extends Control
var dia=["Child of Fate, your time has come. Go on, and forge your destiny in this cruel world.", 
"That weird dream again. No time to think about it though, I'm going to be late for the trial.","Hey, you're so late man. You missed the instructions for the trial, so you're gonna have to duel the instructor himself. Good luck, I'll see you after the trial!","I'd better get going to the arena", " ","I did it!"]
var dia_index=0
var finished = false
var namec=["Acastus"]


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():

	load_dialog()

func _process(delta):
	$"Tween/Next-indicator(1)".visible = finished
	#$"Tween/Next-indicator(1)/AnimationPlayer".visible=finished
	if (Input.is_action_just_pressed("ui_accept") && State.dialog==false):
		load_dialog()
	
#Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func load_dialog():
	if dia_index < dia.size():
		finished=false
		$RichTextLabel.bbcode_text = dia[dia_index]
		$RichTextLabel2.bbcode_text = namec[dia_index]
		$RichTextLabel.percent_visible=0
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible", 0, 1, 1,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()
	else:
		queue_free()
	#State.index+=1
	dia_index+=1
	if dia_index==5:
		$TextureRect.hide();
		$TextureRect.hide();
		State.dialog=true
		Control1._ready()
		

func _on_Tween_tween_completed(object, key):
	finished=true # Replace with function body.
