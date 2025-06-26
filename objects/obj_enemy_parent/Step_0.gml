// =================================== //
//            Execute flag             //
// =================================== //

if (variable_instance_exists(id, "armor") && armor <= 1.8 ){
    can_execute = true;
}

// =================================== //
//               TIMER                 //
// =================================== //

state_timer++;
if(attack_cd > 0){
    attack_cd--;
}
if (stun_duration > 0){
    stun_duration--;
}




switch (state) {
    case stateEnemy.patrol:
        state_patrol();
        break;	
    
    case stateEnemy.chase:
        state_chase();
        break;
    
    case stateEnemy.attack:
        state_attack();
        break;
    
    case stateEnemy.stun:
        state_stun();
        break;
    case stateEnemy.death:
        state_death();
        break;
}

// =================================== //
//             Walk Logic              //
// =================================== //
if (state != stateEnemy.stun){
    var _hor = clamp(target_x - x, -1,1);
    var _ver = clamp(target_y - y, -1,1);
    move_and_collide(_hor * move_spd, _ver * move_spd, [tilemap, obj_enemy_parent]);
}
