extends StaticBody2D

signal hole_hit

var hole_area
var hole_radius = 7
# Called when the node enters the scene tree for the first time.
func _ready():
	hole_area = [
		global_position - Vector2(-hole_radius, -hole_radius),
		global_position - Vector2(-hole_radius, hole_radius),
		global_position - Vector2(hole_radius, hole_radius),
		global_position - Vector2(hole_radius, -hole_radius)]

func get_next_level() -> int:
	return get_tree().current_scene.name.substr(4).to_int() + 1

func change_scene():
	get_tree().change_scene_to_file("res://Levels/lvl_" + str(get_next_level()) + ".tscn")

func is_hit(position: Vector2):
	var is_inside = Geometry2D.is_point_in_polygon(position, hole_area)
	if is_inside:
		print("hole hit")
		emit_signal("hole_hit")
		change_scene()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
