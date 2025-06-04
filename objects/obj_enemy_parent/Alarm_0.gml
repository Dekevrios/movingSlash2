
//if (instance_exists(obj_player) && distance_to_object(obj_player) < distance_player){
    //kejar = true;
    //target_x = obj_player.x;
    //target_y = obj_player.y;
//}
//else{
    //target_x = random_range(xstart - 100, xstart + 100);
    //target_y = random_range(ystart -100, ystart +100);
    //
//}
if (state == stateEnemy.patrol){
    if (instance_exists(obj_player) && distance_to_object(obj_player) < distance_player){
        change_state(stateEnemy.chase);
    }
}
alarm[0] = 60 + irandom(30);
//note : irandom untuk set angka random dari 0 - 30
