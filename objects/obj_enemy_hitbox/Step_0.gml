//facing attack
if (instance_exists(creator)){
    x = creator.x;
    y = creator.y;
    
    var _dir = creator.facing;
    x += lengthdir_x(0,_dir);
    y += lengthdir_y(0,_dir);

    image_angle = _dir;
    //cara 2
    
    cara2();
    
}

//if (!hit_player && instance_exists(obj_player)){
    //
    //if place_meeting(x,y,obj_player) && !obj_player.is_dashing && !obj_player.is_defend{
        //obj_player_control.hp -= damage;
        //hit_player = true;
       //
    //}else if(place_meeting(x,y,obj_player) && obj_player.is_dashing){
     //
        //if instance_exists(creator){
            //with creator{
                //is_stunned = true;
                //stun_duration = 50;
                //
                //change_state(stateEnemy.stun);
                //
                //show_debug_message("terkena stun");
            //}
            //hit_player = true
        //}
    //}else if(place_meeting(x,y,obj_player) && obj_player.is_defend){
        //show_debug_message("player parry")
        ////instance_destroy();
        //if instance_exists(creator){
            //with creator{
                //is_stunned = true;
                //stun_duration = 50;
                //
                //change_state(stateEnemy.stun);
                //
                //show_debug_message("terkena stun");
            //}
        //}
    //}
    //
//}


//cara 2

//if (instance_exists(obj_player)){
    //
    //// daftar id 
    //var attack_id = "attack_" + string(creator) + "_" + string(current_time);
    //
    //if(!variable_struct_exists(creator.attack_hit, attack_id)){
        //
        //creator.attack_hit[$ attack_id] = false
    //}
    //if(!creator.attack_hit[$ attack_id] && place_meeting(x,y,obj_player)){
        //if(!obj_player.is_dashing && !obj_player.is_defend){
            //obj_player_control.hp -= damage;
            //creator.attack_hit[$ attack_id] = true;
        //}
        //
    //}
//}

function cara2(){
    var hit_list = ds_list_create();
    
    var _hit = instance_place_list(x,y,obj_player, hit_list,false);
    if(_hit > 0){
        for(var i = 0; i< _hit;i++){
            var hit_id = hit_list[| i];
            var struct_name = "attack" + string(floor(curr_frame));
            
            if (!variable_struct_exists(creator.attack_hit, struct_name)){
                creator.attack_hit[$ struct_name] = [];
            }
            
            if(!array_contains(creator.attack_hit[$ struct_name], hit_id)){
                array_push(creator.attack_hit[$ struct_name], hit_id);
                if (!hit_id.is_dashing && !hit_id.is_defend){
                    obj_player_control.hp -= damage;
                    
                }
            }
            
        }
        
    }
    ds_list_destroy(hit_list);
}