extends Node

@export var root_node: NodePath

@onready var sounds = {
	&"UI_Clicked": AudioStreamPlayer.new(),
	&"UI_Hover": AudioStreamPlayer.new(),
}

func _ready():
	assert(root_node != null, "Root Node is empty")
	
	# initiate sounds
	for i in sounds.keys():
		sounds[i].stream = load("res://assets/audio/sfx/%s.wav" % i)
		sounds[i].bus = &"SFX"
		add_child(sounds[i])
	
	_install_sounds(get_node(root_node))

func _install_sounds(nodes: Node):
	for node in nodes.get_children():
		if node is Button:
			node.pressed.connect( _play_sfx.bind(&"UI_Clicked") )
			node.mouse_entered.connect( _play_sfx.bind(&"UI_Hover") )
		
		_install_sounds(node)

func _play_sfx(sound: String):
	sounds[sound].play()
