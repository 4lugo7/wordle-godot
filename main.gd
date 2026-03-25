extends Node2D
@onready var buttons: Node2D = $Buttons
@onready var panels: Node2D = $Panels
@onready var enter: Button = $Enter
@onready var delete: Button = $Delete


var alphabet : Array[String] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# creating letter buttons
	
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
			
			pnl.position.x = 150 + 102 * x
			pnl.position.y = 120 + 90 * y
			lbl.text = '1'
			lbl.add_theme_font_size_override("font_size", 30)
			lbl.size = pnl.size
			lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			lbl.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
			



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func button_pressed(index : int):
	var pnls = panels.get_child(0)
	var lbls = pnls.get_child(0)
	lbls.text = char(index)
	
