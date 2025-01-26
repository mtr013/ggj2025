extends Area2D

const FILE_BEGIN = "res://levels/level"

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		var current_scene_file = get_tree().current_scene.scene_file_path
		var next_level_number = current_scene_file.to_int() + 2
		
		var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
		print(next_level_path)
		#get_tree().change_scene_to_file(next_level_path)
