extends Node

const STAGE_FILE = "res://assets/resource/json/stage_data.json"
var stage: Array[StageData]

func _ready():
	var stage_data = FileAccess.get_file_as_string(STAGE_FILE)
	stage_data = JSON.parse_string(stage_data)
	load_stage(stage_data.stage)
	print(stage)

func load_stage(stages: Array):
	for _stage in stages:
		var _s = StageData.new()
		_s.id = _stage.id
		_s.is_tutorial = _stage.is_tutorial
		_s.title = _stage.title
		
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

# check unlocked stage by difficulty
func stage_unlocked(stage_id):
	var progress = SaveLoad.progress.get(Settings.get_current_difficulty())
	
	# using stage_id - 1 because stage will unlcoked if stage_id - 1 is cleared 
	return progress.has(str(stage_id - 1))

# check cleared stage by difficulty
func stage_cleared(stage_id):
	var progress = SaveLoad.progress.get(Settings.get_current_difficulty())
	return progress.has(str(stage_id))
