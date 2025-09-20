class_name Player
extends RigidBody2D

@export var collision_shape: CollisionShape2D
@export_color_no_alpha var body_color: Color

@export var elasticity: float
@export var friction: float


var dragging: bool = false
var launching: bool = false
var drag_start: Vector2
var drag_mouse_start: Vector2
var drag_vector: Vector2

func _draw() -> void:
	if dragging:
		draw_circle(to_local(drag_start), 16.0, Color(body_color, 0.5))
	collision_shape.shape.draw(get_canvas_item(), body_color)

func _input(event: InputEvent) -> void:
	if dragging:
		if event.is_action_released("drag"):
			dragging = false
			launching = true
			queue_redraw()
		if event.is_action_pressed("cancel_drag"):
			dragging = false
			position = drag_start
			queue_redraw()

func _process(delta: float) -> void:
	if dragging:
		var drag_direction: Vector2 = drag_mouse_start.direction_to(get_global_mouse_position())
		var drag_distance: float = drag_mouse_start.distance_to(get_global_mouse_position())
		drag_distance /= log(drag_distance) / log(10.0)
		drag_vector = drag_direction * drag_distance
		position = drag_start + drag_vector
		queue_redraw()

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if launching:
		state.apply_impulse(drag_vector * elasticity * -1)
		launching = false

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("drag"):
		drag_start = position
		drag_mouse_start = get_global_mouse_position()
		dragging = true
