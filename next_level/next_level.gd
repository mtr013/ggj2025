extends Area2D

const FILE_BEGIN = "res://levels/level"

var container = null
var current_level = null

func _ready():
	container = get_tree().current_scene
	current_level = container.find_child("Level?", true, false)

func switch_level():
	var next_level_number = current_level.scene_file_path.to_int() + 1
	var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
	var next_level = load(next_level_path)
	print("Next level - ", next_level_path)
	
	current_level.queue_free()
	container.remove_child(current_level)
	container.add_child(next_level.instantiate())

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		call_deferred("switch_level")
