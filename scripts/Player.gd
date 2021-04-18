extends Sprite


#-Player Data------------------------------------#

var speed = 175
var velocity = Vector2()
var can_shoot = true
var is_dead = false

#------------------------------------------------#


#-Power Up---------------------------------------#

# reload_speed
var reload_speed = 0.1
var default_reload_speed = reload_speed

# damage
var damage = 1
var default_damage = damage

var is_in_power_up = false
var power_up_dict = null
var power_up_cooldown = 3
#------------------------------------------------#


#-Child Resources--------------------------------#

var bullet = preload("res://scenes/Bullet.tscn")

var audio_dict = {
	0: preload("res://assets/audios/laserSmall_000.ogg"),
	1: preload("res://assets/audios/laserSmall_001.ogg"),
	2: preload("res://assets/audios/laserSmall_002.ogg"),
	3: preload("res://assets/audios/laserSmall_003.ogg"),
	4: preload("res://assets/audios/laserSmall_004.ogg")
}

#------------------------------------------------#

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
	
	# Bullet
	if Input.is_action_pressed("click") and Global.node_creation_parent != null and can_shoot and !is_dead:
		var dict = {
			"global_position" : global_position,
			"damage" : damage
		}
		Global.instance_node(bullet, dict, Global.node_creation_parent)
		can_shoot = false
		$ReloadTimer.start()
		
		# Play Audio
		var audio_index = randi() % 4
		$AudioStreamPlayer.stream = audio_dict[audio_index]
		$AudioStreamPlayer.play()
		# 注意：如果没有parent，那么get_parent()将会报错
	
	# PowerUp
	if Input.is_action_just_pressed("skill") and Global.power_up_count > 0 and !is_in_power_up:
		Global.power_up_count -= 1
		is_in_power_up = true
		if Global.node_creation_parent != null:
			Global.node_creation_parent.get_node("UI/Control/PowerUpUI/ColorRect/AnimationPlayer").play("blink")
		power_up_dict = {
			"reload_speed": 0.05,
			"damage": 3
		}
		for variable in power_up_dict:
			set(variable, power_up_dict[variable])
		$PowerUpCoolDownTimer.wait_time = power_up_cooldown
		$PowerUpCoolDownTimer.start()
		
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
		Global.power_up_count = 0
		yield(get_tree().create_timer(1),"timeout")
	# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
	pass

func _on_PowerUpCoolDownTimer_timeout():
	is_in_power_up = false
	for variable in power_up_dict:
		set(variable, get("default_%s" % str(variable)))
	power_up_dict = null
	pass
