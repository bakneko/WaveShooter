extends Node2D

export(Array, PackedScene) var enemies
export(Array, PackedScene) var powerups

func _ready():
	Global.node_creation_parent = self
	Global.score = 0
	pass

func _exit_tree():
	Global.node_creation_parent = null
	pass


func _on_EnemySpawnTimer_timeout():
	var enemy_position = Vector2(rand_range(-160,670), rand_range(-90,390))
	while enemy_position.x < 640 and enemy_position.x > -80 and enemy_position.y < 360 and enemy_position.y  > -45:
		enemy_position = Vector2(rand_range(-160,670), rand_range(-90,390))
	
	var enemy_index = Global.randw([7,2,1])
	# random with weight.
	var dict = {
		"global_position" : enemy_position
	}
	Global.instance_node(enemies[enemy_index], dict, self)
	pass


func _on_DifficultyTimer_timeout():
	if $EnemySpawnTimer.wait_time > 0.5:
		$EnemySpawnTimer.wait_time -= 0.1
	pass


func _on_PowerUpSpawnTimer_timeout():
	var power_up_index = Global.randw([1])
	# random instance powerups
	var position = Vector2(randi() % 620 + 11, randi() % 340 + 11)
	var dict = {
		"global_position" : position
	}
	Global.instance_node(powerups[power_up_index], dict, self)
	pass
