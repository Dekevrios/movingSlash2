function Script1(){
	//check melee 1 collision
	var _hit_by_attack = ds_list_create();
	with (_anim) {
		var _enemies = [obj_EnemyParent, obj_Drum];
		var _hits = instance_place_list(x,y,_enemies,_hit_by_attack,false);
		for (var i = 0;i < _hits;i++) {
			var _hit_id = _hit_by_attack[| i];
			var _struct_name = "melee1" + string(floor(image_index));
				
			if (struct_exists(other.hit_by_attack,_struct_name) && !array_contains(other.hit_by_attack[$ _struct_name],_hit_id)) {
				array_push(other.hit_by_attack[$ _struct_name],_hit_id);
				var _baseDamage = obj_PlayerControl.player_str(other);
				var _damage = _baseDamage;
				apply_damage_melee(other,_hit_id,_damage,true,true);
				if (_hit_id.is_dead && _hit_id.object_index != obj_EnemyBulletParent && _hit_id.object_index != obj_Drum) {
					combat_heat_melee_add();
				};
				var _sound = audio_play_sound(sfx_LeaPunchHit,1,false);
			};
		};
		ds_list_destroy(_hit_by_attack);
		
		if (anim_end) {
			other.melee_second_sound = false;
			reset_melee_state(other);
			other.state = other.state_idle;
		};
	};

}