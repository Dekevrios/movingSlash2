
motion_set(target,speed);
//
//if !variable_instance_exists(id,"creator"){
    ////save musuh yang keluarin bullet
    //creator = instance_nearest(x,y,obj_enemy1);
    //show_debug_message("bullet si : "+ object_get_name(creator.object_index)); //cek siapa yg lemapar bullet
//}

if instance_exists(obj_player){
    if place_meeting(x,y,obj_player) && !obj_player.is_dashing && !obj_player.is_defend{
        obj_player_control.hp -= 1;
        instance_destroy();
    }else if(place_meeting(x,y,obj_player) && obj_player.is_dashing){
        instance_destroy();
    }else if(place_meeting(x,y,obj_player) && obj_player.is_defend){
        show_debug_message("player parry")
        instance_destroy();
        
        //stun enemy
        if instance_exists(creator){
            with creator{
                is_stunned = true;
                stun_duration = 120;
              
                speed = 0;
                
                show_debug_message("terkena stun");
            }
        }
           
    }
}

