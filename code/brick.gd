extends StaticBody2D

var health = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func hit():
	health -= 1	
	
	if health == 1:
		var color = $Sprite2D.modulate
		color.a = 0.5
		$Sprite2D.modulate = color
	
	if health == 0:
		self.queue_free()
		
