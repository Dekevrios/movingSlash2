
motion_set(target,speed);

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
                stun_duration = 50;
                
                change_state(stateEnemy.stun);
                
                show_debug_message("terkena stun");
            }
        }
           
    }
}

