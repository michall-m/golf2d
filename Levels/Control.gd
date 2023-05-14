extends Control

var node: Node;
var score: int = 0;


# Called when the node enters the scene tree for the first time.
func _ready():
	node = get_node("ScoreTable");
	update_text()

func increment():
	score += 1
	
func set_pos(position: Vector2):
	var diff = Vector2(DisplayServer.window_get_size())/2
	set_global_position(position - diff)
	
func update_text():
	node.text = "Your score is: " + str(score) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_text()
