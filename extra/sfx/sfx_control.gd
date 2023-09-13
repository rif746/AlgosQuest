extends Node
class_name SFXControl

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
	
	install_sounds(get_node(root_node))

func install_sounds(nodes: Node):
	for node in nodes.get_children():
		if node is Button:
			node.pressed.connect( _play_sfx.bind(&"UI_Clicked") )
			node.mouse_entered.connect( _play_sfx.bind(&"UI_Hover") )
		elif node is LineEdit:
			node.mouse_entered.connect( _play_sfx.bind(&"UI_Hover") )
		elif node is Slider:
			node.mouse_entered.connect( _play_sfx.bind(&"UI_Hover") )
			node.drag_started.connect( _play_sfx.bind(&"UI_Clicked") )
		elif node is TouchScreenButton:
			node.pressed.connect( _play_sfx.bind(&"UI_Clicked") )
		
		install_sounds(node)

func _play_sfx(sound: String):
	sounds[sound].play()
