extends CenterContainer

@export var dot_radius := 2.0
@export var dot_color := Color.GREEN

func _draw(): 
	draw_circle(Vector2(0,0), dot_radius, dot_color)

func _ready():
	queue_redraw()

func _process(_delta):
	pass
