extends Node2D

@onready var A = $A 
@onready var B = $B 
@onready var C = $C 
@onready var D = $D 
@onready var line = $Line2D

var t = 0.0
@export_range(0,150,1,"Tail segment length","prefer_slider") var segment_length = 50.0 # length of each tail segment
@export_range(0,5,0.1,"Wave amplitude","prefer_slider") var wave_amplitude = 2.0 # the max "up" and "down" movement of one node relative to node in front of it
@export_range(0,3,0.1,"Wave speed","prefer_slider") var wave_speed = 2.0 # the speed of the up and down movement
# an amplitude of 1 gives around 45° movement, 3.2 gives around 360°

#extra parameters to tweak motion
@export_range(0,2,0.1,"Phase delay","prefer_slider") var phase_delay = 0.5
@export_range(0,1,0.1,"Amplitude diference invert factor","prefer_slider") var amplitude_difference_invert_factor = 1.0
@export_range(0,3,0.1,"Amplitude difference factor","prefer_slider") var amplitude_difference_factor = 1.5

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
		var offset = i * phase_delay  # phase delay (if offset is zero, then you have a straight stick)
		# offsets looks like the "stiffness" of the tail
		
		var k = i / (float(points.size())-1) # to make the wave amplitute different in each tail section
		# first node is 1/3 th of the amplitude, second node 1/2, third 1 full amplitude (in the case with a head + 3 nodes)
		# you can also do the opposite 
		
		var falloff = lerp(1-k,k,amplitude_difference_invert_factor) * amplitude_difference_factor #to invert the wave amplitute difference between nodes
		# (k makes movement increase from head to tail)
		# (1-k makes movement decrease from head to tale)
		# amplitude_difference_invert_factor lerps between the two
		
		var angle = sin(t * wave_speed - offset) * wave_amplitude * falloff
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
