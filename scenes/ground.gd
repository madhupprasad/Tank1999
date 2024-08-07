extends Node2D

@export var Enemy: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_enemies()

func spawn_enemies():
	# Get all Marker2D nodes that are children of this node
	var spawn_points = get_children().filter(func(node): return node is Marker2D)
	# Spawn an enemy at each marker position
	for spawn_point in spawn_points:
		var enemy = Enemy.instantiate()
		enemy.position = spawn_point.global_position
		add_child(enemy)
