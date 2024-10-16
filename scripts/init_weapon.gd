extends Node3D

@export var weapon_type : Weapons

@onready var weapon_mesh : MeshInstance3D = %WeaponMesh

func _ready():
	load_weapon()

func _unhandled_input(event):
	if event.is_action_pressed("weapon1"):
		weapon_type = load("res://weapons/tovarok/tovarok.tres")
		load_weapon()
	if event.is_action_pressed("weapon2"):
		weapon_type = load("res://weapons/tovarok/tovarokL.tres")
		load_weapon()
	if event.is_action_pressed("weapon3"):
		weapon_type = load("res://weapons/katana/katana.tres")
		load_weapon()

func load_weapon():
	weapon_mesh.mesh = weapon_type.mesh
	position = weapon_type.position
	rotation_degrees = weapon_type.rotation
	
func attack():
	var camera = %FPSCamera
	var space_state = camera.get_world_3d().direct_space_state
	var screen_center = get_viewport().size / 2
	var origin = camera.project_ray_origin(screen_center)
	var end = origin + camera.project_ray_normal(screen_center) * 1000
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_bodies = true
	var result = space_state.intersect_ray(query)
	print(result)
	if result:
		pass
