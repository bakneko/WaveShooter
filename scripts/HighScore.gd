extends Label

func _ready():
	text = "最高分: {0}".format(Global.high_score)
	pass

func _process(_delta):
	Global.high_score = Global.score if Global.score > Global.high_score else Global.high_score
	# Python 的三目运算符
	pass


func _on_Area2D_area_entered(area):
	if area.is_in_group("player"):
		modulate = Color("#ffffff64")
	pass


func _on_Area2D_area_exited(area):
	if area.is_in_group("player"):
		modulate = Color("#ffffffff")
	pass
