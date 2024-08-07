extends Area2D

const SPEED = 1300.0
var area_direction = Vector2(0, 0)
var debounce = false

func _process(delta):
	self.position += area_direction * SPEED * delta

func _on_body_entered(body):
	# Stops an error that crashes the game.
	if debounce == true:
		return
	debounce = true
	
	if body.is_in_group("bricks"):
		body.hit()
		self.queue_free()

	if body.is_in_group("enemies"):
		body.hit()
		self.queue_free()
		
		
