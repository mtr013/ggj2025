extends CharacterBody2D

@export var move_speed : float = 50
@export var starting_direction : Vector2 = Vector2(0, 1)

@onready var animation_tree = $AnimationTree
@onready var pearl_label = get_node("/root/Gameplay/MarginContainer/HBoxContainer/Label")

var pearl_counter = null
var container = null
var current_level = null

const FILE_BEGIN = "res://levels/level"

func _ready():
	update_animation_parameters(starting_direction)
	pearl_counter = pearl_label.text.to_int()
	
	container = get_tree().current_scene
	current_level = container.find_child("Level?", true, false)

func _physics_process(_delta):
	# Get input direction
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	update_animation_parameters(input_direction)
	
	# Update velocity
	velocity = input_direction * move_speed
	
	# Move and slide function uses velocity of character body to move character on map
	move_and_slide()

func update_animation_parameters(move_input : Vector2):
	# Don't change animation parameters if there is no input
	if (move_input != Vector2.ZERO):
		animation_tree.set("parameters/Idle/blend_position", move_input)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Pearl"):
		set_pearl(pearl_counter + 1)
				
	if area.is_in_group("Clam"):
		await get_tree().create_timer(0.25).timeout
		
		var current_level_number = current_level.scene_file_path.to_int()
		var current_level_path = FILE_BEGIN + str(current_level_number) + ".tscn"
		var reset_level = load(current_level_path)
	
		current_level.queue_free()
		container.remove_child(current_level)
		container.add_child(reset_level.instantiate())

func set_pearl(new_pearl_count: int) -> void:
	pearl_counter = new_pearl_count
	pearl_label.text = str(pearl_counter)


func _on_timer_timeout() -> void:
	pass # Replace with function body.
