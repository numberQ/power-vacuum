class_name Player
extends Node2D

@export var collision_shape: CollisionShape2D
@export_color_no_alpha var color: Color

var dragging: bool = false

func _draw() -> void:
	collision_shape.shape.draw(get_canvas_item(), color)

func _input(event: InputEvent) -> void:
	if dragging:
		if event.is_action_released("drag"):
			dragging = false
		if event.is_action_pressed("release"):
			dragging = false

func _process(delta: float) -> void:
	if dragging:
		position = get_global_mouse_position()

func _on_CharacterBody2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("drag"):
		dragging = true
