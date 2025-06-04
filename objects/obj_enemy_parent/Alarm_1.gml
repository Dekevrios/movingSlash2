image_blend = c_white;

if(hp <= 0){
    instance_destroy();
    
}else {
	if(get_damage && !is_stunned){
        change_state(stateEnemy.stun);
    }
}

get_damage = false;