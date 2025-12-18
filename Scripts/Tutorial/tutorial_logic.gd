extends Node3D


@onready var timerNextLevel = get_node("Timer2")

@onready var checkGrabbed = false
@onready var checkGrabbedPump = false
@onready var checkInSling = false
@onready var checkGrabSling = false
@onready var checkShotOnce = false
@onready var hitScarecrowOnce = false

#@onready var stage1 = 1 	#beginning, nothing done
#var stage2 = 1 #player now needs to find grab button 
var stage3 = 1 #player now need to grab pumpkin
var stage4 = 0 #player needs to drop pumpkin into slingshot
var stage5 = 0 #player needs to grab slingshot
var stage6 = 0 #player needs to launch pumpkin
var stage7 = 0 #player needs to hit at least 1 scarecrow
var stage8 = 0 #player has finished the tutorial



#All Player related objects
@onready var playerReference = get_parent().get_node("Player")
@onready var playerLHAND = playerReference.get_node("Left")
@onready var playerRHAND = playerReference.get_node("Right")

@onready var slingReference = get_parent().get_node("Slingshot")
@onready var pumpSlingRef = null

#All Text related objects
@onready var allText = get_parent().get_node("Progression_Text")
@onready var stageText2 = allText.get_node("Text_Step_2")
@onready var stageTextfirst3 = allText.get_node("Text_Step_first3")
@onready var stageText3 = allText.get_node("Text_Step_3")
@onready var stageTextother3 = allText.get_node("Text_Step_other3")
@onready var stageText4 = allText.get_node("Text_Step_4")
@onready var stageText5 = allText.get_node("Text_Step_5")
@onready var stageText6 = allText.get_node("Text_Step_6")
@onready var stageText7 = allText.get_node("Text_Step_7")
@onready var stageTextEnd = allText.get_node("Text_Step_End")
@onready var stageTextEndTimer = allText.get_node("Text_Step_End_Time")

#All the enemy spawners
@onready var groupStaticSpawners = get_parent().get_node("StaticSpawners")

#@onready var seeArrow = stageTextother3.get_node("Arrow")


func _process(_delta: float) -> void:

	if stage8 == 1:
		stageText2.visible = false
		stageTextfirst3.visible = false
		stageText3.visible = false
		stageTextother3.visible = false
		stageText4.visible = false
		stageText5.visible = false
		stageText6.visible = false
		stageText7.visible = false
		stageTextEnd.visible = true
		stageTextEndTimer.visible = true
	elif stage7 == 1:
		stageText2.visible = false
		stageTextfirst3.visible = false
		stageText3.visible = false
		stageTextother3.visible = false
		stageText4.visible = false
		stageText5.visible = false
		stageText6.visible = false
		stageText7.visible = true
		stageTextEnd.visible = false
	elif stage6 == 1:
		stageText2.visible = false
		stageTextfirst3.visible = false
		stageText3.visible = false
		stageTextother3.visible = false
		stageText4.visible = false
		stageText5.visible = false
		stageText6.visible = true
		stageText7.visible = false
		stageTextEnd.visible = false
	elif stage5 == 1:
		stageText2.visible = false
		stageTextfirst3.visible = false
		stageText3.visible = false
		stageTextother3.visible = false
		stageText4.visible = false
		stageText5.visible = true
		stageText6.visible = false
		stageText7.visible = false
		stageTextEnd.visible = false
	elif stage4 == 1:
		stageText2.visible = false
		stageTextfirst3.visible = false
		stageText3.visible = false
		stageTextother3.visible = false
		stageText4.visible = true
		stageText5.visible = false
		stageText6.visible = false
		stageText7.visible = false
		stageTextEnd.visible = false
	elif stage3 == 1:
		stageText2.visible = true
		stageTextfirst3.visible = true
		stageText3.visible = true
		stageTextother3.visible = true
		stageText4.visible = false
		stageText5.visible = false
		stageText6.visible = false
		stageText7.visible = false
		stageTextEnd.visible = false
		stageTextEndTimer.visible = false
	#elif stage2 == 1: #text_step_2 is visible, everything else not
		#stageText2.visible = true
		#stageTextfirst3.visible = false
		#stageText3.visible = false
		#stageTextother3.visible = false
		#stageText4.visible = false
		#stageText5.visible = false
		#stageText6.visible = false
		#stageText7.visible = false
		#stageTextEnd.visible = false
	#print("Time left: ", timerNextLevel.time_left) 
	
	if Globals.score > 0 && checkShotOnce == true && hitScarecrowOnce == false:
		stage7 += 1
		stage8 += 1
		timerNextLevel.start()
		hitScarecrowOnce = true
		#get_tree().change_scene_to_file("res://Scenes/pumpkinchuckin.tscn")
	
	if pumpSlingRef != null:
		if pumpSlingRef.flung == true:
			if checkShotOnce == false:
				stage6 += 1
				stage7 += 1
				checkShotOnce = true
				#timerNextLevel.start()
				#get_tree().change_scene_to_file("res://Scenes/pumpkinchuckin.tscn")
	
	if checkInSling == false:
		if slingReference.loaded == true:
			stage4 += 1
			stage5 += 1	
			checkInSling = true
			pumpSlingRef = slingReference.loadedPumpkin
	#This is checking left hand status 
	if playerLHAND.handGripping:
		#stage2 += 1
		#if checkGrabbed == false:
			#checkGrabbed = true
			#stage3 += 1
		if playerLHAND.grabbedArea.name == "PumpkinArea":
			print("Grabbing pumpkin")
			if checkGrabbedPump == false:
			#stage2 += 1
				stage3 += 1
				stage4 += 1
				checkGrabbedPump = true
				print("iterate pumpkin")
		elif playerRHAND.grabbedArea.name == "SlingArea":
			if checkGrabSling == false:
				stage5 += 1
				stage6 += 1	
				checkGrabSling = true
	#This is checking right hand status 
	if playerRHAND.handGripping == true:
		#stage2 += 1
		#if checkGrabbed == false:
			#checkGrabbed = true
			#stage3 += 1
		if playerRHAND.grabbedArea.name == "PumpkinArea":
			print("grabbing pumpkin")
			if checkGrabbedPump == false:
				print("Iterate pumpkin")
				#stage2 += 1
				stage3 += 1
				stage4 += 1
				checkGrabbedPump = true
		elif playerRHAND.grabbedArea.name == "SlingArea":
			if checkGrabSling == false:
				stage5 += 1
				stage6 += 1	
				checkGrabSling = true

#
#func _on_timer_timeout() -> void:
	#print("leve==========================")
	#get_tree().change_scene_to_file("res://Scenes/pumpkinchuckin.tscn")


func _on_timer_2_timeout() -> void:
	Globals.score = 0
	groupStaticSpawners.queue_free()
	get_tree().change_scene_to_file("res://Scenes/pumpkinchuckin.tscn")
