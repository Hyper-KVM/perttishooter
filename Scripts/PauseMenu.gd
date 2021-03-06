extends Node

# Node references
onready var pause_label = $PauseLabel
onready var quit_button = $QuitButton
onready var main_menu_button = $MainMenuButton
onready var resume_button = $ResumeButton
onready var volume_button = $Volume
onready var music = get_parent().get_parent().get_node("AudioStreamPlayer") # Spaghetti

func _ready():
	get_viewport().connect("size_changed", self, "_on_viewport_size_changed")
	set_positions()
	set_visibility()

func _process(delta):
	inputs()

func set_visibility():
	pause_label.visible = false
	quit_button.visible = false
	main_menu_button.visible = false
	resume_button.visible = false
	volume_button.visible = false

func inputs():
	if Input.is_action_just_pressed("pause") and !get_tree().paused:
		pause_label.visible = true
		quit_button.visible = true
		main_menu_button.visible = true
		resume_button.visible = true
		volume_button.visible = true
		get_tree().paused = true
	elif Input.is_action_just_pressed("pause") and get_tree().paused:
		pause_label.visible = false
		quit_button.visible = false
		main_menu_button.visible = false
		resume_button.visible = false
		volume_button.visible = false
		get_tree().paused = false

func set_positions():
	pause_label.rect_position = Vector2((get_viewport().size.x - pause_label.get_rect().size.x) / 2, get_viewport().size.y / 4)
	quit_button.rect_position = Vector2((get_viewport().size.x - quit_button.get_rect().size.x) / 2, get_viewport().size.y / 4 + 250)
	main_menu_button.rect_position = Vector2((get_viewport().size.x - main_menu_button.get_rect().size.x) / 2, get_viewport().size.y / 4 + 175)
	resume_button.rect_position = Vector2((get_viewport().size.x - resume_button.get_rect().size.x) / 2, get_viewport().size.y / 4 + 100)
	volume_button.rect_position = Vector2((get_viewport().size.x - volume_button.get_rect().size.x) / 2, get_viewport().size.y / 4 + 325)

func _on_MainMenuButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_ResumeButton_pressed():
	pause_label.visible = false
	quit_button.visible = false
	main_menu_button.visible = false
	resume_button.visible = false
	volume_button.visible = false
	get_tree().paused = false

func _on_viewport_size_changed():
	set_positions()

func _on_Volume_toggled(button_pressed):
	if button_pressed:
		Settings.music = false
		music.stop()
	elif !button_pressed:
		Settings.music = true
		music.play()
