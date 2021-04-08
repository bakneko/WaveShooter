extends Sprite

var speed = 175
var velocity = Vector2()
var can_shoot = true

var bullet = preload("res://scenes/Bullet.tscn")

func _ready():
	Global.player = self
	pass

func _exit_tree():
	Global.player = null
	pass

func _process(delta):
	# 当pressed 时，返回值为1，相加相减解决同时按下方向相反的按键时的问题。
	velocity.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	velocity.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	velocity = velocity.normalized()
	# 乘以delta保证速度一致
	global_position += velocity * speed * delta
	
	if Input.is_action_pressed("click") and Global.node_creation_parent != null and can_shoot:
		Global.instance_node(bullet, global_position, Global.node_creation_parent)
		$ReloadTimer.start()
		can_shoot = false
		# 注意：如果没有parent，那么get_parent()将会报错
	pass


func _on_ReloadTimer_timeout():
	can_shoot = true
	pass
