extends Node2D
class_name enemy_holder

@onready var enemy_check : Timer = $enemy_check

var tower_peasant_scene : PackedScene
var proj_balloon_scene : PackedScene
var the_level : level
var stage_tokens_dict : Dictionary[int, float] = {
	0 : 5,
	1 : 15,
	2 : 30,
	3 : 60,
	4 : 120, 
	5 : 240, 
	6 : 480,
	7 : 960
}

const enemy_cost : Dictionary[int, float] = {
	0 : 2,
	1 : 5
	#2 : 8
}

func set_up(level_node : level):
	tower_peasant_scene = load("uid://ix4fvtcg36jb")
	proj_balloon_scene = load("uid://cr6ab512dq7oq")
	the_level = level_node
	enemy_check.timeout.connect(try_progress)
	spawn_enemies(0)
	
func try_progress():
	if get_child_count() > 1 or the_level.the_camera.follow: return
	else:
		the_level.the_camera.follow = true
		the_level.current_stage += 1
		spawn_enemies(the_level.current_stage)
	
func spawn_enemies(stage):
	while stage_tokens_dict[stage] > 1:
		var attempted_enemy = randi_range(0,len(enemy_cost)-1)
		if stage_tokens_dict[stage] - enemy_cost[attempted_enemy] < 0: continue
		stage_tokens_dict[stage] -= enemy_cost[attempted_enemy]
		if attempted_enemy == 0:
			var attempt_count : int= 0
			while(attempt_count < 5):
				attempt_count += 1
				var y = randi_range(the_level.the_tower.highest_y_tile + (stage * -12), the_level.the_tower.highest_y_tile + stage * -12 -10)
				var x = randi_range(the_level.the_tower.min_x, the_level.the_tower.min_x + 3)
				if Vector2i(x,y) in the_level.the_tower.tiles and the_level.the_tower.tiles[Vector2i(x,y)].occupient == null:
					the_level.set_up_tower_entity(tower_peasant_scene,Vector2(x,y))
					break
		if attempted_enemy == 1:
			var ranx = [randi_range(0,300), randi_range(780,1080)][randi_range(0,1)]
			var rany = randi_range(the_level.the_tower.highest_y_tile * -64 + stage * 12 * -64 + -128, the_level.the_tower.highest_y_tile * -64 + (stage+1) * 12 * -64 + 128)
			var balloon : balloon_enemy = proj_balloon_scene.instantiate()
			add_child(balloon)
			balloon.position = Vector2(ranx,rany)
			balloon.set_up(the_level)	
			
			
	
	
