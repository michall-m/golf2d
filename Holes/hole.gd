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

func is_hit(position: Vector2):
	var is_inside = Geometry2D.is_point_in_polygon(position, hole_area)
	if is_inside:
		print("hole hit")
		emit_signal("hole_hit")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
