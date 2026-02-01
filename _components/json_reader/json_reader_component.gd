class_name JSONReaderComponent
extends Node


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
