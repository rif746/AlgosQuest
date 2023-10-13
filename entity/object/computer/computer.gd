extends StaticBody2D
class_name Computer

@onready var stage_rule_panel = %StageRulePanel


signal window_closed()

func install_computer(stage_data: StageData):
	var rules: Array[String] = []
	rules.append("Terdapat %d objek yang tersebar." % stage_data.content.size())
	rules.append("Objek tersebut berisi pecahan materi %s." % stage_data.title)
	rules.append("Telusuri dungeon dan temukan semua objek tersebut.")
	rules.append("Setelah semua objek ditemukan, pergi ke pintu keluar dan selesaikan kuis yang tersedia.")
	rules.append("Permainan akan berakhir jika pemain berhasil keluar atau waktu permainan habis.")
	stage_rule_panel.install_rule(stage_data.title, rules)

func interaction():
	stage_rule_panel.show()


func _on_panel_hidden():
	window_closed.emit()
