extends Node2D
@onready var buttons: Node2D = $Buttons
@onready var panels: Node2D = $Panels
@onready var enter: Button = $Enter
@onready var delete: Button = $Delete
@onready var panel: Panel = $Panel
@onready var color_rect: ColorRect = $Panel/ColorRect
@onready var too_short: Label = $TooShort
@onready var invalid_word: Label = $InvalidWord
@onready var endlabel: Label = $endlabel
@onready var restart: Button = $Restart


signal ui_accept
var alphabet : Array[String] = []
var posx = 0
var posy = 0

func load_allowed_five_letter_words():
	return FileAccess.get_file_as_string("res://materials/valid-wordle-words.txt").split("\n")

func load_real_five_letter_word():
	return FileAccess.get_file_as_string('res://materials/full_word_list.txt').split("\n")

var word = load_real_five_letter_word().get(randi_range(0, 1742)).to_upper().split("")
var allowed_words = load_allowed_five_letter_words()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(word)
	endlabel.text = ''
	invalid_word.visible = false
	too_short.visible = false
	
	# creating letter button
	delete.pressed.connect(delete_pressed)
	enter.pressed.connect(enter_pressed)
	
	for i in range(65, 91):
		alphabet.append(char(i))
		var button = Button.new()
		button.text = char(i)
		
		button.pressed.connect(button_pressed.bind(i))
		
		buttons.add_child(button)
		
	for y in range(2):
		for x in range(13):
			#x1 50 y1 540, x2 480 y2 640
			var btn = buttons.get_child(x + 13 * y)
			btn.position.x = 40 + 50 * x
			btn.position.y = 800 + y * 90
			btn.size.x = 48
			btn.size.y = 48
	
	# creating panels for label input
	for y in range(6):
		for x in range(5):
			var panel = Panel.new()
			var label = Label.new()
			
			panels.add_child(panel)
			var pnl = panels.get_child(x + 5 * y)
			pnl.add_child(label)
			
			var lbl = pnl.get_child(0)
			
			pnl.size = Vector2(50, 50)
			pnl.position.x = 135 + 102 * x
			pnl.position.y = 200 + 90 * y
			
			lbl.add_theme_font_size_override("font_size", 30)
			lbl.size = pnl.size
			lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			lbl.vertical_alignment = VERTICAL_ALIGNMENT_CENTER

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed('ui_accept'):
		enter_pressed()
	
	if Input.is_action_just_pressed('ui_text_backspace'):
		delete_pressed()
	

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode in range(65, 91):
		if event.pressed:
			button_pressed(event.keycode)

func button_pressed(index : int):
	invalid_word.visible = false
	too_short.visible = false
	
	if posy < 6:
		if posx == 0:
			var pnls = panels.get_child(posx + 5 * posy)
			var lbls = pnls.get_child(0)
			lbls.text = char(index)
			posx += 1
		elif posx == 1:
			var pnls = panels.get_child(posx + 5 * posy)
			var lbls = pnls.get_child(0)
			lbls.text = char(index)
			posx += 1
		elif posx == 2:
			var pnls = panels.get_child(posx + 5 * posy)
			var lbls = pnls.get_child(0)
			lbls.text = char(index)
			posx += 1
		elif posx == 3:
			var pnls = panels.get_child(posx + 5 * posy)
			var lbls = pnls.get_child(0)
			lbls.text = char(index)
			posx += 1
		elif posx == 4:
			var pnls = panels.get_child(posx + 5 * posy)
			var lbls = pnls.get_child(0)
			lbls.text = char(index)
			posx += 1

func delete_pressed():
	invalid_word.visible = false
	too_short.visible = false
	
	if posx == 1:
		var pnls = panels.get_child(0 + 5 * posy)
		var lbls = pnls.get_child(0)
		lbls.text = ""
		posx -= 1
	elif posx == 2:
		var pnls = panels.get_child(1 + 5 * posy)
		var lbls = pnls.get_child(0)
		lbls.text = ""
		posx -= 1
	elif posx == 3:
		var pnls = panels.get_child(2 + 5 * posy)
		var lbls = pnls.get_child(0)
		lbls.text = ""
		posx -= 1
	elif posx == 4:
		var pnls = panels.get_child(3 + 5 * posy)
		var lbls = pnls.get_child(0)
		lbls.text = ""
		posx -= 1
	elif posx == 5:
		var pnls = panels.get_child(4 + 5 * posy)
		var lbls = pnls.get_child(0)
		lbls.text = ""
		posx -= 1

func enter_pressed():
	if posy < 6:
		if posx == 5:
			var used_letter = []
			var duplicate_letter = has_duplicate(word)
			var pnls_array = panels.get_children()
			var buttons_array = buttons.get_children()
			var entered_word = get_entered_word(posy)
			var entered_word_array = entered_word.split("")
			var time_ellapsed = 0.43
			
			if allowed_words.has(entered_word):
				for i in range(5):
					# flip_animation
					flip_animation(pnls_array[i + 5 * posy], 0)
					
					if pnls_array[i + 5 * posy].get_child(0).text == word[i]:
						var style = panels.get_child(i + 5 * posy).get_theme_stylebox("panel").duplicate()
						style.bg_color = Color(0.139, 0.584, 0.137, 1.0)
						panels.get_child(i + 5 * posy).add_theme_stylebox_override("panel", style)
						duplicate_letter.erase(pnls_array[i + 5 * posy].get_child(0).text)
						used_letter.append(pnls_array[i + 5 * posy].get_child(0).text)
					elif not pnls_array[i + 5 * posy].get_child(0).text == word[i] and word.has(pnls_array[i + 5 * posy].get_child(0).text):
						if duplicate_letter.has(pnls_array[i + 5 * posy].get_child(0).text):
							var style = panels.get_child(i + 5 * posy).get_theme_stylebox("panel").duplicate()
							style.bg_color = Color(0.827, 0.733, 0.0, 1.0)
							panels.get_child(i + 5 * posy).add_theme_stylebox_override("panel", style)
							duplicate_letter.erase(pnls_array[i + 5 * posy].get_child(0).text)
							used_letter.append(pnls_array[i + 5 * posy].get_child(0).text)
						elif not used_letter.has(pnls_array[i + 5 * posy].get_child(0).text):
							var style = panels.get_child(i + 5 * posy).get_theme_stylebox("panel").duplicate()
							style.bg_color = Color(0.827, 0.733, 0.0, 1.0)
							panels.get_child(i + 5 * posy).add_theme_stylebox_override("panel", style)
							used_letter.append(pnls_array[i + 5 * posy].get_child(0).text)
					elif not pnls_array[i + 5 * posy].get_child(0).text == word[i] and not word.has(pnls_array[i + 5 * posy].get_child(0).text):
						var used_button = buttons_array[ord(pnls_array[i + 5 * posy].get_child(0).text)-65]
						used_button.add_theme_color_override("font_color", Color(0.149, 0.149, 0.149, 1.0))
						
					
					flip_animation(pnls_array[i + 5 * posy], 50)
				
				posx = 0
				posy += 1
				
			else:
				print('not a valid word')
				invalid_word.visible = true
			
			if posy == 6:
				endlabel.text = "You suck at wordle!"
				restart.visible = true
			
			if entered_word_array == word:
				endlabel.text = "You won wordle!"
				posy = 7
				restart.visible = true
			
		else:
			too_short.visible = true


func has_duplicate(word: Array) -> Array:
	var seen = []
	var duplicate_letter = []
	for s in word:
		if seen.has(s):
			duplicate_letter.append(s)
			duplicate_letter.append(s)
		seen.append(s)
	return duplicate_letter

func get_entered_word(y_pos):
	var entered_word = ''
	var pnls_array = panels.get_children()
	for i in range(5):
		entered_word = entered_word + pnls_array[i + 5 * y_pos].get_child(0).text
	return entered_word

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()

func flip_animation(panel_i, size):
	var tween1 = create_tween()
	tween1.tween_property(panel_i, "size:y", size, 0.215)
	await tween1.finished
