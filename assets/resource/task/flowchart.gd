extends Resource
class_name Flowchart

enum FLOWCHART {
	INPUT = 1,
	PROCESS = 2,
	OUTPUT = 3,
	BRANCH = 4 
}

var regex = RegEx.new()

@export var id: int
@export var instruction: String:
	set(_instruction):
		instruction = _instruction
		regex.compile("\\((\\w+)\\)")
		var result = regex.search_all(_instruction)
		
@export var type: FLOWCHART:
	set(_type):
		assert(
			!FLOWCHART.values().bsearch(_type),
			"kode %d tidak cocok dengan kode flowchart yang didukung" % _type
		)
		type = _type

var code: String
