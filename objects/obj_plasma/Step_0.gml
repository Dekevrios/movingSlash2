var _enemy = instance_place(x,y,obj_enemy_parent);

var _col = instance_place(x,y,obj_wall);
if(place_meeting(x,y,obj_wall)){
    //show_debug_message(" wall kena")
}

if (_col != noone){
    show_debug_message(" wall id: " + string(_col));
    
    if(bounce_count > 0 ){
        show_debug_message("image angle: "+ string(_col.image_angle))
        var _dir = _col.image_angle * 2 - direction;
        if (_dir < 0 ) {
            _dir += 360;
        }
        //update
        direction = _dir;
        image_angle = direction;
        bounce_count--;
    }
        
    
    
}else{
    alarm[0] = 120;
}