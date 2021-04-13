extends Label

func _ready():
	text = "Highscore: %s" % String(Global.high_score)
	pass

func _process(delta):
	Global.high_score = Global.score if Global.score > Global.high_score else Global.high_score
	# Python 的三目运算符
	pass
