extends Node2D

@onready var A = $A 
@onready var B = $B 
@onready var C = $C 
@onready var D = $D 
@onready var line = $Line2D

var t = 0.0
var segment_length = 50.0 # length of each tail segment
var wave_amplitude = 1 # the max "up" and "down" movement of one node relative to node in front of it
var wave_speed = 2 # the speed of the up and down movement
# an amplitude of 1 gives around 45° movement, 3.2 gives around 360°

var head_pos = Vector2(200, 240) # the position of the first node

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
		var offset = i * 0.5  # phase delay (if offset is zero, then you have a straight stick)
		# offsets looks like the "stiffness" of the tail
		
		var angle = sin(t * wave_speed - offset) * wave_amplitude
		# - ofset looks the tail movement is starting at the head node and moving down to the last node
		# + ofstet looks like the tail end starts the movement, going up towards the head (looks wrong)
		
		var dir = Vector2.RIGHT.rotated(angle) # can be seen as a unit vector in the direction of the calculated angle
		points[i].position = points[i - 1].position + dir * segment_length

	line.points = [A.position, B.position, C.position, D.position] #draws a line through all the points
	queue_redraw() # redraw the draw fucntion
	
# Function to draw the nodes (so they are visible)
func _draw(): 
	var nodes = [A, B, C, D] 
	for node in nodes: 
		draw_circle(node.position, 4, Color.YELLOW)
