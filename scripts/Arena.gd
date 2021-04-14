extends Node2D

export(Array, PackedScene) var enemies

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
	
	# 0-2 
	# random a index to generate.
	# ToDo : 其实应该增加生成权重
	var enemy_index = randi() % enemies.size()
	Global.instance_node(enemies[enemy_index], enemy_position, self)
	pass


func _on_DifficultyTimer_timeout():
	if $EnemySpawnTimer.wait_time > 0.5:
		$EnemySpawnTimer.wait_time -= 0.05
	pass
