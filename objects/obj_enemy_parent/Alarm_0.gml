
if (state == stateEnemy.patrol){
    if (instance_exists(obj_player) && distance_to_object(obj_player) < distance_player){
        change_state(stateEnemy.chase);
    }
}
alarm[0] = 60 + irandom(30);
//note : irandom untuk set angka random dari 0 - 30
