extends Resource

const MATERIAL_FILE = "res://data/material.json"

func load_material():
	var material_data = FileAccess.get_file_as_string(MATERIAL_FILE)
	material_data = JSON.parse_string(material_data)
	return material_data.material
