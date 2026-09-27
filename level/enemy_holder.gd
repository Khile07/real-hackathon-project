extends Node2D
class_name enemy_holder

@onready var enemy_check : Timer = $enemy_check

var tower_peasant_scene : PackedScene
var proj_balloon_scene : PackedScene
var goblim_tower_scene : PackedScene
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
	1 : 5,
	2 : 8
}

func set_up(level_node : level):
	tower_peasant_scene = load("uid://ix4fvtcg36jb")
	proj_balloon_scene = load("uid://cr6ab512dq7oq")
	goblim_tower_scene = load("uid://cewkro6ate0c5")
	the_level = level_node
	enemy_check.timeout.connect(try_progress)
	spawn_enemies(0)
	
func try_progress():
	for child in get_children():
		if child is not Timer and child is Node2D:
			if the_level.the_player.position.distance_to(child.position) > 2000: child.queue_free()
	if get_child_count() > 1 or the_level.the_camera.follow: return
	else:
		if the_level.current_stage == 6:
			the_level.fader.visible = true
			the_level.the_camera.won = true
			the_level.the_camera.ending_the_world = true
			return
		the_level.the_camera.follow = true
		SignalManager.wave_ended.emit()
		the_level.current_stage += 1
		
	
func spawn_enemies(stage):
	while stage_tokens_dict[stage] > 1:
		var attempted_enemy = randi_range(0,len(enemy_cost)-1)
		if stage_tokens_dict[stage] - enemy_cost[attempted_enemy] < 0: continue
		stage_tokens_dict[stage] -= enemy_cost[attempted_enemy]
		if attempted_enemy == 0:
			var attempt_count : int= 0
			while(attempt_count < 5):
				attempt_count += 1
				var y : int
				if the_level.current_stage == 0: y = randi_range(the_level.the_tower.highest_y_tile + (stage * -12), the_level.the_tower.highest_y_tile + stage * -12 -10)
				else: y = randi_range(the_level.the_tower.highest_y_tile + ((stage-1) * -12), the_level.the_tower.highest_y_tile + (stage-1) * -12 -10)
				var x = randi_range(the_level.the_tower.min_x, the_level.the_tower.min_x + 3)
				if Vector2i(x,y) in the_level.the_tower.tiles and the_level.the_tower.tiles[Vector2i(x,y)].occupient == null:
					the_level.set_up_tower_entity(tower_peasant_scene,Vector2(x,y))
					break
		if attempted_enemy == 1:
			var ranx = [randi_range(-300,0), randi_range(1080,1380)][randi_range(0,1)]
			var rany = randi_range(720 + stage * -768 + -128, stage * -768 + 300)
			var balloon : balloon_enemy = proj_balloon_scene.instantiate()
			add_child(balloon)
			balloon.position = Vector2(ranx,rany)
			balloon.set_up(the_level)	
		if attempted_enemy == 2:
			var no_tower_yet : bool = true
			for child in the_level.get_children(): if child is goblim_tower: no_tower_yet = false
			if not no_tower_yet:
				stage_tokens_dict[stage] += enemy_cost[attempted_enemy]
				continue
			var ranx = [randi_range(-300,0), randi_range(1080,1380)][randi_range(0,1)]
			var rany = randi_range(720 + stage * -768 + -128, stage * -768 + 300)
			var balloon : goblim_tower = goblim_tower_scene.instantiate()
			the_level.add_child(balloon)
			balloon.position = Vector2(ranx,rany)
			balloon.the_level = the_level
			
	
	
