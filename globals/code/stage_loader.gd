extends Node

const STAGE_FILE = "res://assets/resource/json/stage_data.json"
var stage: Array[StageData]
var flowchart: Flowchart = Flowchart.new()

func _ready():
	var stage_data = FileAccess.get_file_as_string(STAGE_FILE)
	stage_data = JSON.parse_string(stage_data)
	flowchart.instruction = "buat variabel (nama) dengan tipedata (string) atau (integer)"
	flowchart.type = 1
	load_stage(stage_data.stage)

func load_stage(stages: Array):
	var progress = SaveLoad.progress.get(Settings.get_current_difficulty())
	for _stage in stages:
		var _s = StageData.new()
		_s.id = _stage.id
		_s.is_tutorial = _stage.is_tutorial
		_s.title = _stage.title
		_s.is_unlocked = progress.has(str(_stage.id - 1))
		_s.is_cleared = progress.has(str(_stage.id))
		
		# load material content
		for content in _stage.content:
			var _content = MaterialContent.new()
			_content.chapter = content.chapter
			_content.text = content.text
			_content.intro = content.intro
			_s.content.append(_content)
		
		# load stage question
		for quest in _stage.quest:
			var _quest = Quest.new()
			_quest.text = quest.text
			
			# load question answer
			for answer in quest.answer:
				var _answer = QuestAnswer.new()
				_answer.text = answer.text
				_answer.correct = answer.correct
				_quest.answer.append(_answer)
				
			_s.quest.append(_quest)
		
		stage.append(_s)
