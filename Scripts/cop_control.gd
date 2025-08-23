extends CharacterBody3D

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@export var movement_speed: float = 2.0

func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 0.5
	navigation_agent.target_desired_distance = 0.5

	# Make sure to not await during _ready.
	actor_setup.call_deferred()

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		return

	var current_agent_position: Vector3 = global_position
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if(event.is_action("select")):
		var selected_position = get_mouse_3D_pos();
		if(selected_position): 
			set_movement_target(selected_position);

func get_mouse_3D_pos():
	var viewport := get_viewport();
	var mouse_position := viewport.get_mouse_position();
	var camera := viewport.get_camera_3d();
	var origin := camera.project_ray_origin(mouse_position)
	var direction := camera.project_ray_normal(mouse_position)
	var ray_length := camera.far
	var end := origin + direction * ray_length
	var space_state := get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(origin, end)
	var result := space_state.intersect_ray(query)
	return result.get("position");
