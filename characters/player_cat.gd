extends CharacterBody2D

@export var move_speed : float = 50
@export var starting_direction : Vector2 = Vector2(0, 1)

@onready var animation_tree = $AnimationTree
@onready var pearl_label = get_node("/root/Gameplay/MarginContainer/HBoxContainer/Label")

var pearl_counter = 0

func _ready():
	update_animation_parameters(starting_direction)

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
		print(pearl_counter)
				
	if area.is_in_group("Clam"):
		get_tree().reload_current_scene()

func set_pearl(new_pearl_count: int) -> void:
	pearl_counter = new_pearl_count
	pearl_label.text = str(pearl_counter)
