extends CharacterBody3D

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@export var movement_speed: float = 2.0
@export var turn_speed = 0.2;

var is_talking = false;

func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 0.5
	navigation_agent.target_desired_distance = 1
	
	DialogueManager.dialogue_started.connect(dialogue_start);
	DialogueManager.dialogue_ended.connect(dialogue_end);

	# Make sure to not await during _ready.
	actor_setup.call_deferred()
	
	

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame
	
	
func dialogue_start(resource): 
	is_talking = true;
	set_movement_target(get_global_position())
	
	
func dialogue_end(resource): 
	is_talking = false;

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)
	
func set_character_rotation():
	var target: Basis = Basis.looking_at(velocity.normalized());
	basis = basis.slerp(target, 0.2);

func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		velocity = Vector3(0, 0, 0);
		return

	var current_agent_position: Vector3 = global_position
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	set_character_rotation();
	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if(is_talking): return;
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
