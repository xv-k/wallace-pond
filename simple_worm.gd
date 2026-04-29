extends Node2D

@onready var A = $A 
@onready var B = $B 
@onready var C = $C 
@onready var D = $D 
@onready var line = $Line2D

var t = 0.0
var segment_length = 80.0 
var wave_amplitude = 0.5 
var wave_speed = 2.0

var head_pos = Vector2(200, 240)

# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	line.width = 1 
	line.default_color = Color.WHITE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Function to draw the nodes (so they are visible)
func _draw(): 
	var nodes = [A, B, C, D] 
	for node in nodes: 
		draw_circle(node.position, 4, Color.YELLOW)
