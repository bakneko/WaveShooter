extends Node

const SAVE_DIR = "user://saves/"
const VERSION = "v1.1"

var save_path = SAVE_DIR + "savedata"

# 修复如果没有Parent的问题
var node_creation_parent = null
var player = null
var camera = null
var score = 0
var high_score = 0
var power_up_count = 0

# 全局的实例化子场景代码
func instance_node(node, dictionary, parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	for variable in dictionary:
		node_instance.set(variable, dictionary[variable])
	# Python 字典
	return node_instance

# 权重生成
# 传入权重列表，返回随机出来的数在权重列表中的位置
func randw(weights):
	var total_weight = 0
	# 计算权重列表的总和
	for i in weights:
		total_weight += i
	# 生成一个从1到total_weight的随机数
	var random = randi() % total_weight + 1
	# 从0到weights.size() - 1进行循环
	# !!!注意range(a, b)是从a 到 b - 1 
	var current = 0
	for i in range(0, weights.size()):
		current += weights[i]
		if random - current <= 0:
			# 属于当前的组
			return i
		else:
			continue

func _ready():
	var file: File = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			var data = file.get_var()
			# set highscore
			# high_score = data["high_score"]
			for variable in data:
				if (variable != "version" and data["version"] == VERSION):
					set(variable, data[variable])
			file.close()

func _exit_tree():
	# Dictionary for storing data
	var data: Dictionary = {
		"high_score" : high_score,
		"version" : VERSION
	}
	
	var directory: Directory = Directory.new()
	if !directory.dir_exists(SAVE_DIR):
		# warning-ignore:return_value_discarded
		directory.make_dir_recursive(SAVE_DIR)
	
	var file: File = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(data)
		file.close()

func _process(_delta):
	if Input.is_action_pressed("exit"):
		get_tree().quit(0)
	pass
