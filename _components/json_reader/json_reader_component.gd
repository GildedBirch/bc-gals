class_name JSONReaderComponent
extends Node


@export var folder: String


func read_from_folder(file_name: String) -> Dictionary:
	if file_name == "":
		assert(false, "File name not given.")
	if folder == "":
		assert(false, "No folder set.")
	
	var file: FileAccess = FileAccess.open("%s%s" % [folder, file_name], FileAccess.READ)
	var json_string: String = file.get_as_text()

	var json: JSON = JSON.new()
	var parse_result: Error = json.parse(json_string)
	if not parse_result == OK:
		assert(false, "JSON Parse Error: %s in %s at line %s" % [json.get_error_message(), json_string, json.get_error_line()])
	
	return json.data


func read(file_path: String) -> Dictionary:
	if file_path == "":
		assert(false, "File path not given.")
	
	var file: FileAccess = FileAccess.open(file_path, FileAccess.READ)
	var json_string: String = file.get_as_text()

	var json: JSON = JSON.new()
	var parse_result: Error = json.parse(json_string)
	if not parse_result == OK:
		assert(false, "JSON Parse Error: %s in %s at line %s" % [json.get_error_message(), json_string, json.get_error_line()])
	
	return json.data
