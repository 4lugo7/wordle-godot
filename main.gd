extends Node2D
@onready var buttons: Node2D = $Buttons
@onready var panels: Node2D = $Panels
@onready var enter: Button = $Enter
@onready var delete: Button = $Delete
@onready var panel: Panel = $Panel
@onready var color_rect: ColorRect = $Panel/ColorRect



var alphabet : Array[String] = []
var posx = 0
var posy = 0
var word = ["S", "T", "O", "N", "E"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
			btn.position.y = 720 + y * 90
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
			pnl.position.x = 150 + 102 * x
			pnl.position.y = 120 + 90 * y
			
			lbl.add_theme_font_size_override("font_size", 30)
			lbl.size = pnl.size
			lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			lbl.vertical_alignment = VERTICAL_ALIGNMENT_CENTER

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func button_pressed(index : int):
	if posx == 0:
		var pnls = panels.get_child(0 + 5 * posy)
		var lbls = pnls.get_child(0)
		lbls.text = char(index)
		posx += 1
	elif posx == 1:
		var pnls = panels.get_child(1 + 5 * posy)
		var lbls = pnls.get_child(0)
		lbls.text = char(index)
		posx += 1
	elif posx == 2:
		var pnls = panels.get_child(2 + 5 * posy)
		var lbls = pnls.get_child(0)
		lbls.text = char(index)
		posx += 1
	elif posx == 3:
		var pnls = panels.get_child(3 + 5 * posy)
		var lbls = pnls.get_child(0)
		lbls.text = char(index)
		posx += 1
	elif posx == 4:
		var pnls = panels.get_child(4 + 5 * posy)
		var lbls = pnls.get_child(0)
		lbls.text = char(index)
		posx += 1

func delete_pressed():
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
	if posx == 5:
		var pnls_array = panels.get_children()
		for i in range(5):
			if pnls_array[i + 5 * posy].get_child(0).text == word[i]:
				print(pnls_array[i + 5 * posy].get_child(0).text)
				var style = panels.get_child(i + 5 * posy).get_theme_stylebox("panel").duplicate()
				style.bg_color = Color(0.139, 0.584, 0.137, 1.0)
				panels.get_child(i + 5 * posy).add_theme_stylebox_override("panel", style)
		posx = 0
		posy += 1
	
	if posy == 5:
		pass
