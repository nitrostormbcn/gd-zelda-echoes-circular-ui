@tool
extends EditorScript

var origin = preload("res://scenes/echo_card_circ.tscn")

func _run():
	const folder_path = "res://echoes/"
	const destination_path = "res://echo_scenes_circ/"
	var echoes = DirAccess.get_files_at(folder_path)
	print(echoes)
	for echo in echoes:
		var slices = echo.split(".", true, 1)
		var name = slices[0]
		var extension = slices[1]
		if "png" == extension:
			print(name)
			var scene = PackedScene.new()
			var card = origin.instantiate()
			var new_texture = load(folder_path + echo)
			card.get_node("TextureRect").set_texture(new_texture)
			
			var result = scene.pack(card)
			if result == OK:
				var error = ResourceSaver.save(scene, destination_path + name + ".tscn")
				if error != OK:
					push_error("An error occurred while saving the scene to disk.")
