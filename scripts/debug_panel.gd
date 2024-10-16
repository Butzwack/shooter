extends PanelContainer

@onready var property_container = $MarginContainer/VBoxContainer
var property
var fps : String

func _ready():
	Global.debug = self
	visible = true

func _input(event):
	if event.is_action_pressed("console"):
		visible = !visible

func add_property(title: String, value, order):
	var target
	target = property_container.find_child(title, true, false)
	if !target:
		target = Label.new()
		property_container.add_child(target)
		target.name = title
		target.text = target.name + ": " + str(value)
	elif visible:
		target.text = title + ": " + str(value)
		property_container.move_child(target, order)

#func add_debug_property(title: String, value):
#	property = Label.new()
#	property_container.add_child(property)
#	property.name = title
#	property.text = property.name + str(value)

func _process(delta):
	Global.debug.add_property("fps", fps, 0)
	if visible:
		fps = "%.1f" % (1.0/delta)
		#property.text = property.name + ": " + fps
