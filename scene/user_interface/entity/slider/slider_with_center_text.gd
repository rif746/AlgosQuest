extends HSlider
class_name HSLiderWithLabel

func _value_changed(val):
	$Label.text = str(round(val * 100), "%")

