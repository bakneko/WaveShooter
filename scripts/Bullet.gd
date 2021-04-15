extends Sprite

var velocity = Vector2(1,0)
var speed = 250

export(int) var damage = 1

var look_once = true

func _process(delta):
	if look_once:
		look_at(get_global_mouse_position())
		look_once = false
		# 设置指向方向
	global_position += velocity.rotated(rotation) * speed * delta
	# 朝着指定方向移动
	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass
