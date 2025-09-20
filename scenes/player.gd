class_name Player
extends Node2D

@export var collision_shape: CollisionShape2D
@export_color_no_alpha var body_color: Color

var dragging: bool = false
var drag_start: Vector2
var last_mouse_position: Vector2

func _draw() -> void:
	collision_shape.shape.draw(get_canvas_item(), body_color)

func _input(event: InputEvent) -> void:
	if dragging:
		if event.is_action_released("drag") || event.is_action_pressed("release"):
			dragging = false
			position = drag_start

func _process(delta: float) -> void:
	if dragging:
		var drag_delta := get_global_mouse_position() - last_mouse_position
		position += drag_delta
	last_mouse_position = get_global_mouse_position()

func _on_CharacterBody2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("drag"):
		drag_start = position
		dragging = true
