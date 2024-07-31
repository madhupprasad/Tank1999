extends CharacterBody2D

const SPEED = 300.0

var current_x_dir = -1
var current_y_dir = 0
var screen_size
@export var Bullet: PackedScene
var actual_rate = 0.4
var timer = 0       

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	timer += delta
	var direction_x = Input.get_axis("move_left", "move_right")
	var direction_y = Input.get_axis("move_up", "move_down")
	velocity.x = 0
	velocity.y = 0
		
	if direction_x != 0:
		velocity.x = direction_x * SPEED
		
		if direction_x != current_x_dir or direction_y != current_y_dir:
			if direction_x == -1:
				self.rotation_degrees = 0
			elif direction_x == 1:
				self.rotation_degrees = 180
			current_x_dir = direction_x
			current_y_dir = 0

	elif direction_y != 0:
		velocity.y = direction_y * SPEED
	
		if direction_x != current_x_dir or direction_y != current_y_dir:
			if direction_y == -1:
				self.rotation_degrees = 90
			elif direction_y == 1:
				self.rotation_degrees = -90
			current_y_dir = direction_y
			current_x_dir = 0
 
	if Input.get_action_raw_strength("shoot")  && timer >= actual_rate:
		var temp = Bullet.instantiate()
		add_sibling(temp)
		temp.global_position = get_node("BulletSpawn").get("global_position")

		var bullet_direction = Vector2(current_x_dir, current_y_dir).normalized()
		temp.set("area_direction", bullet_direction)
		timer = 0
		
	move_and_slide()

	
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
