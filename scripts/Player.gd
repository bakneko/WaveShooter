extends Sprite

var speed = 175
var velocity = Vector2()
var can_shoot = true
var is_dead = false

var reload_speed = 0.1
var default_reload_speed = reload_speed

var power_up_reset = []

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
	# 防止Player跑出屏幕
	global_position.x = clamp(global_position.x, 10, 630)
	global_position.y = clamp(global_position.y, 10, 350)
	# 乘以delta保证速度一致
	if !is_dead:
		global_position += velocity * speed * delta
	
	if Input.is_action_pressed("click") and Global.node_creation_parent != null and can_shoot and !is_dead:
		Global.instance_node(bullet, global_position, Global.node_creation_parent)
		$ReloadTimer.start()
		can_shoot = false
		# 注意：如果没有parent，那么get_parent()将会报错
	pass


func _on_ReloadTimer_timeout():
	can_shoot = true
	$ReloadTimer.wait_time = reload_speed 
	pass

func _on_HitBox_area_entered(area):
	# 玩家死亡
	if area.is_in_group("enemy"):
		visible = false
		is_dead = true
		if Global.is_first_round:
			Global.is_first_round = false
		yield(get_tree().create_timer(1),"timeout")
	# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
	pass

func _on_PowerUpCoolDownTimer_timeout():
	# 解决加入多个PowerUp的问题
	if power_up_reset.find("PowerUpReload") != null:
		reload_speed = default_reload_speed
		power_up_reset.erase("PowerUpReload")
	pass
