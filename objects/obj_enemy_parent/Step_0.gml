
state_timer++;
if(shoot_cd > 0){
    shoot_cd--;
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
    
    case stateEnemy.shoot:
        state_shoot();
        break;
    
    case stateEnemy.stun:
        state_stun();
        break;
    
    case stateEnemy.execute:
        state_execute();
        break;
}

if (state != stateEnemy.stun && state != stateEnemy.execute){
    var _hor = clamp(target_x - x, -1,1);
    var _ver = clamp(target_y - y, -1,1);
    move_and_collide(_hor * move_spd, _ver * move_spd, [tilemap, obj_enemy_parent]);
}


function state_patrol(){
    //cek jarak player
    if (instance_exists(obj_player) && distance_to_object(obj_player) < distance_player){
        change_state(stateEnemy.chase);
        return;
    }
    
    //set new random point
    if (point_distance(x,y,target_x,target_y) < 10){
        target_x = random_range(xstart - 100, xstart + 100);
        target_y = random_range(ystart -100, ystart +100);
    }
}

function state_chase(){
    if (!instance_exists(obj_player) || distance_to_object(obj_player) > distance_player *1.2){
       change_state(stateEnemy.patrol);
        return;
    }
    
    target_x = obj_player.x;
    target_y = obj_player.y;
    
    if (distance_to_object(obj_player) < distance_player *0.8){
        change_state(stateEnemy.shoot);
        return;
    }
    
}

function state_shoot(){
    // player terdeksi -> pindah ke state shoot -> spawn bullet 
    
    if (!instance_exists(obj_player) || distance_to_object(obj_player) > distance_player * 1.2){
        change_state(stateEnemy.patrol);
        return;
    }
    
    target_x = obj_player.x;
    target_y = obj_player.y;
    
    if shoot_cd <= 0{
        shoot_cd =  shoot_cd_max;
    
        with instance_create_depth(x,y,depth,obj_bullet){
            creator = other;
            
        }
    
    }
    if (distance_to_object(obj_player) > distance_player *0.8){
        change_state(stateEnemy.chase);
        return;
    }
    
    
}

function state_stun(){
    // enemy attack -> player defenbd action -> enemy terkena efek stun -> berubah warna dan diam
    image_blend = c_red;
    speed = 0;
    
    is_stunned = (stun_duration > 0);
    
    if(stun_duration <= 0){
        is_stunned = false;
        change_state(stateEnemy.patrol);
        return;
    }
    
}

function state_execute(){
    //  armor enemy habis -> keluar trigger untuk execute -> player masuk execute trigger 
}

function change_state(new_state){
    switch (state){
        case stateEnemy.stun:
            image_blend = c_white;
            break;
        case stateEnemy.shoot:
            image_blend = c_white;
            break;
    }
    
    state = new_state;
    state_timer = 0;
    
    switch(new_state){
        case stateEnemy.patrol:
            target_x = random_range(xstart - 100, xstart + 100);
            target_y = random_range(ystart -100, ystart +100);
            break;
        case stateEnemy.stun:
            
            break;
        case stateEnemy.execute:
            
            break;
            
    }
    
}

function get_stunned(duration){
    stun_duration = duration;
    change_state(stateEnemy.stun);
}



//if !variable_instance_exists(id, "is_stunned"){
    //is_stunned =false;
    //stun_duration = 0;
//}
//
//if is_stunned{
    //stun_duration -=1;
    //image_blend = c_red;
    //speed = 0;
    //kejar =false;
    //
    //if stun_duration <= 0{
        //is_stunned = false;
        //image_blend = c_white;
        //
    //}
    //
//}



// knockback
//if(alarm[1] >= 0){
    //
    //target_x = x + kb_x;
    //target_y = y +kb_y;
//}


//arah movement
//var _hor = clamp(target_x - x, -1,1);
//var _ver = clamp(target_y - y, -1, 1);

//shoot bullet
//if kejar == true{
    //cd --;
    //if cd <= 0{
        //cd = 50;
        //
        //
        //with instance_create_depth(x,y,depth,obj_bullet){
            //creator = other;
            //
        //}
        //
    //}
//}


//move_and_collide(_hor * move_spd, _ver * move_spd, [tilemap, obj_enemy_parent]);