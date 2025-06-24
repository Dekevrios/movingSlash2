image_blend = c_white;

// damage and health indicator

if(hp <= 0){
    //buff share
    if (instance_exists(obj_player) && executed = true){
        with (obj_player){
            apply_buff(other.buff_type,other.buff_amount,other.buff_duration);
        }
    }
    
    instance_destroy();
    
}else {
	if(get_damage && !is_stunned){
        change_state(stateEnemy.stun);
    }
}

get_damage = false;