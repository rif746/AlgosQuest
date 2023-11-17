extends StaticBody2D
class_name Computer

var stage_data: StageData

signal window_close()


func _ready():
	stage_data = StageManager.stage_data
	StageManager.panel_visibility_changed.connect(_on_close_info_panel)


func interaction():
	var rules: String
	rules = "[ul]"
	rules += "Terdapat %d objek yang tersebar.\n" % stage_data.content.size()
	rules += "Objek tersebut berisi pecahan materi %s.\n" % stage_data.title
	rules += "Telusuri dungeon dan temukan semua objek tersebut.\n"
	rules += "Setelah semua objek ditemukan, pergi ke pintu keluar dan selesaikan kuis yang tersedia.\n"
	rules += "Permainan akan berakhir jika pemain berhasil keluar atau waktu permainan habis.\n"
	rules += "[/ul]"
	StageManager.toggle_info_panel.emit(stage_data.title, rules)


func _on_close_info_panel(_id, _visible):
	if(_id == stage_data.title):
		window_close.emit()
		StageManager.object_ready = true
