image_blend = c_white;

// damage and health indicator
if(hp <= 0){
    //buff share
    change_state(stateEnemy.death);
    
}else {
	if(get_damage && !is_stunned){
        change_state(stateEnemy.stun);
    }
}

get_damage = false;