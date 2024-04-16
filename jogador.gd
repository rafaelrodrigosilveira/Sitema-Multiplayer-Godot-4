extends Node2D

var velocidade = 70
var nickname = ""

func _ready():
	pass



func _process(delta):
	if is_multiplayer_authority():
		var axys = Vector2.ZERO
		if Input.is_action_pressed("ui_right"):
			axys += Vector2(1,0)
		if Input.is_action_pressed("ui_left"):
			axys += Vector2(-1,0)
		if Input.is_action_pressed("ui_up"):
			axys += Vector2(0,-1)
		if Input.is_action_pressed("ui_down"):
			axys += Vector2(0,1)
		position += axys * velocidade * delta
	pass

func set_nickname(nickname):
	self.nickname = nickname
	$Nickname.text = nickname
	pass
