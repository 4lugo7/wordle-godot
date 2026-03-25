extends Node2D
@onready var buttons: Node2D = $Buttons
@onready var labels: Node2D = $Labels

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
			btn.position.x = 20 + 25 * x
			btn.position.y = 360 + y * 40
			btn.size.x = 20
			btn.size.y = 20
	
	# creating label for input
	for y in range(6):
		for x in range(5):
			var lbl = Label.new()
			labels.add_child(lbl)
			
			lbl.position.x = 50 + 40 * x
			lbl.position.y = 50 + 50 * y
			



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func button_pressed(index : int):
	print(char(index))
