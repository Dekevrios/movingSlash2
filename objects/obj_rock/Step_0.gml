//if place_meeting(x,y,obj_player){
    //show_debug_message("batu");
    //if pick {
    //
    //if keyboard_check_pressed(ord("v")){
        //show_debug_message("keambil");
        //pick = false;
        //
        //direction = point_direction(x,y,mouse_x,mouse_y);
        //speed = rock_spd;
    //}
//}
//}

if thrown && rock_spd >0{
    
    x += lengthdir_x(rock_spd, direction);
    y += lengthdir_y(rock_spd, direction);
    
    curr_distance += rock_spd; // jarak tempuh
    
    if curr_distance >= distance{
        instance_destroy();
        show_debug_message("rock gone");
    }
} else{
    if rock_spd > 0 && !thrown{
        rock_spd = 0;
        show_debug_message("rock diam");
    }
}

