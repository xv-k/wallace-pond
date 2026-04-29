extends Node2D

@onready var A = $A 
@onready var B = $B 
@onready var C = $C 
@onready var D = $D 
@onready var line = $Line2D

var t = 0.0
var segment_length = 50.0 
var wave_amplitude = 1 
var wave_speed = 4.0

var head_pos = Vector2(200, 240)

# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	line.width = 2 
	line.default_color = Color.WHITE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	t += delta

	A.position = head_pos

	var points = [A, B, C, D]

	for i in range(1, points.size()):
		var offset = i * 0.8  # phase delay
		var angle = sin(t * wave_speed - offset) * wave_amplitude
		
		var dir = Vector2.RIGHT.rotated(angle)
		points[i].position = points[i - 1].position + dir * segment_length

	line.points = [A.position, B.position, C.position, D.position]
	queue_redraw()
	
# Function to draw the nodes (so they are visible)
func _draw(): 
	var nodes = [A, B, C, D] 
	for node in nodes: 
		draw_circle(node.position, 4, Color.YELLOW)
