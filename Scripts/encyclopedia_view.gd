extends Control

@onready var page1_button = $PanelContainer/HBoxContainer/MarginContainer/ButtonContainer/Page1
@onready var page2_button = $PanelContainer/HBoxContainer/MarginContainer/ButtonContainer/Page2
@onready var page3_button = $PanelContainer/HBoxContainer/MarginContainer/ButtonContainer/Page3
@onready var button_container = $PanelContainer/HBoxContainer/MarginContainer/ButtonContainer

@onready var icon_panel = $PanelContainer/HBoxContainer/MarginContainer2/VBoxContainer/Panel/Icon
@onready var title_label = $PanelContainer/HBoxContainer/MarginContainer2/VBoxContainer/Panel2/Panel/Title
@onready var description_label = $PanelContainer/HBoxContainer/MarginContainer2/VBoxContainer/Panel2/Panel/Description

@export var target_scene : SceneStorage.SceneID = SceneStorage.SceneID.NOTHING

func _ready():
	page1_button.set_meta("page_id", "PAGE_001")
	page2_button.set_meta("page_id", "PAGE_002")
	page3_button.set_meta("page_id", "PAGE_003")
	
	for btn in button_container.get_children():
		if btn is Button:
			btn.pressed.connect(_on_page_button_pressed.bind(btn))

func _process(delta: float) -> void:
	update_buttons()

func update_buttons():
	for btn in button_container.get_children():
		if btn is Button:
			var page_id = btn.get_meta("page_id")
			btn.visible = PlayerData.is_unlocked(page_id)
		
func _on_page_button_pressed(button: Button):
	var page_id = button.get_meta("page_id")
	var page = EncyclopediaDb.pages.get(page_id)
	if page == null:
		print("Page not found: ", page_id)
		return
	var icon = load(page["image"])
	var stylebox = StyleBoxTexture.new()
	stylebox.texture = icon
	icon_panel.add_theme_stylebox_override("panel", stylebox)
	
	title_label.text = page["title"]
	
	description_label.clear()
	description_label.append_text(page["text"])

	print("Displayed page:", page_id)
	
	
func _on_close_encyclopedia_button_pressed() -> void:
	if target_scene != SceneStorage.SceneID.NOTHING:
		print("Bringing you to another place")
		SceneLoader.load_scene(target_scene)
		GlobalTimer.add_timer(0.5)
		GlobalTimer.timeout.connect(Callable(self,"on_timeout"))
