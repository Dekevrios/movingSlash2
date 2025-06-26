// Inherit the parent event
event_inherited();

attack_range = 10;
facing = 0;


// melee attack
state_attack = function(){
     if (!instance_exists(obj_player) || distance_to_object(obj_player) > distance_player * 1.2){
        change_state(stateEnemy.patrol);
        return;
    }
    
    target_x = obj_player.x;
    target_y = obj_player.y;
    
    if (instance_exists(obj_player)) {
        facing = point_direction(x, y, obj_player.x, obj_player.y);
    }
    
    if (attack_cd <= 0 && distance_to_object(obj_player) < attack_range ){
        attack_cd = attack_cd_max;
        
        var _attack = instance_create_depth(x,y,depth,obj_enemy_hitbox);
        _attack.creator = id;
        
    }
    
    //sprite_index = spr_slimeAtt;
    
    
    // balik ke chase jika distance tmelewati gizmo
    if (distance_to_object(obj_player) > attack_range *1.5){
        change_state(stateEnemy.chase);
        return;
    }
    
    if (distance_to_object(obj_player) > attack_range) {
        target_x = obj_player.x;
        target_y = obj_player.y;
    } else {
       //stop gerak
        target_x = x;
        target_y = y;
    }
    
}

