//cek enemy di area
with (obj_enemy_parent){
    var _dist = point_distance(x,y,other.x,other.y);
    
    //enemy di dalam area
    if (_dist <= other.radius){
        //damage
        if (variable_instance_exists(id, "hp")){
            hp -= other.dmg;
            get_damage = true;
            show_debug_message("kena dmg");
        }
        
        //slow 
        in_field = true;
        field_id = other.id;
        if (!variable_instance_exists(id, "new_spd")){
            move_spd = new_spd;
        }
        new_spd = move_spd - other.slow_move;
       
        
        show_debug_message("kena slow ")
        //image_blend = c_aqua;
        
        
    }else if(variable_instance_exists(id, "in_field") && in_field && 
             variable_instance_exists(id, "field_id") && field_id == other.id){
        
        in_field = false;
        field_id = noone;
        
        if (variable_instance_exists(id, "move_spd")) {
            new_spd = move_spd;
            show_debug_message("speed kembali");
        }
        
        
    }
    
}
 alarm[1] = dmg_frame;