extends CharacterBody2D

var speed = 350
var direction = Vector2(1,0)
var possible_directions = [Vector2(1,0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1)]

func get_dir(direction):
	var new_d = direction
	while new_d == direction:
		print(new_d)
		new_d = possible_directions[randi() % possible_directions.size()]
	return new_d
	
func _physics_process(delta):
	velocity = speed * direction
	move_and_slide()
	
	if is_on_wall() or is_on_ceiling() or is_on_floor():
		if direction == Vector2(0,1):
			position.y -= 10
		if direction == Vector2(0,-1):
			position.y += 10
		if direction == Vector2(1,0):
			position.x -= 10
		if direction == Vector2(-1,0):
			position.x += 10
		direction = get_dir(direction)
		velocity = speed * direction


		
func hit():
	self.queue_free()
