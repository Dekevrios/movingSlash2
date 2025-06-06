// =================================== //
//            Execute flag             //
// =================================== //

if (variable_instance_exists(id, "armor") && armor <= 1.8 ){
    can_execute = true;
}

// =================================== //
//               TIMER                 //
// =================================== //

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
}

// =================================== //
//             Walk Logic              //
// =================================== //
if (state != stateEnemy.stun){
    var _hor = clamp(target_x - x, -1,1);
    var _ver = clamp(target_y - y, -1,1);
    move_and_collide(_hor * move_spd, _ver * move_spd, [tilemap, obj_enemy_parent]);
}

// =================================== //
//          PATROL FUNCTION            //
// =================================== //
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

// =================================== //
//          CHASE FUNCTION             //
// =================================== //
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

// =================================== //
//          SHOOT FUNCTION             //
// =================================== //

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

// =================================== //
//          STUN FUNCTION              //
// =================================== //

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
       
    }
}


function get_stunned(duration){
    stun_duration = duration;
    change_state(stateEnemy.stun);
}


