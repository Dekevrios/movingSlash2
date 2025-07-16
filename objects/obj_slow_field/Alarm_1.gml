//cek enemy di area
with (obj_enemy_parent){
    var _dist = point_direction(x,y,other.x,other.y);
    
    //enemy di dalam area
    if (_dist <= other.radius){
        //damage
        if (variable_instance_exists(id, "hp")){
            hp -= other.dmg;
        }
        
        //slow 
        in_field = true;
        field_id = other.id;
        if (!variable_instance_exists(id, "adjust_spd")){
            move_spd = adjust_spd;
        }
        
        adjust_spd = move_spd * 0.25;
        image_blend = c_aqua;
        
        
    }else if(variable_instance_exists(id, "in_field") && in_field && 
              variable_instance_exists(id, "field_id") && field_id &&
              field_id == other.id){
        
        in_field = false;
        field_id = noone;
        
        if (variable_instance_exists(id, "move_spd")) {
            adjust_spd = move_spd;
        }
        
        
    }
    
}
 alarm[1] = dmg;