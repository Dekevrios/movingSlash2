target_x = x;
target_y = y;

alarm[0] = 60;

tilemap = layer_tilemap_get_id("tile_col");

kb_x = 0;
kb_y = 0

get_damage = false;
attack_cd = 0;
attack_cd_max = 50;

//cd = 50;
kejar = false;

is_stunned = false;
stun_duration =0;
move_spd = 0.5;

can_execute = false;
executed = false;
execute_min = 2

last_hit_by = noone;

//BUFF 
buff_type = "none";
buff_duration = 0;
buff_amount = 0;


// =================================== //
//          PATROL FUNCTION            //
// =================================== //
state_patrol = function(){
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
state_chase = function(){
    if (!instance_exists(obj_player) || distance_to_object(obj_player) > distance_player *1.2){
       change_state(stateEnemy.patrol);
        return;
    }
    
    target_x = obj_player.x;
    target_y = obj_player.y;
    
    if (distance_to_object(obj_player) < distance_player *0.8){
        change_state(stateEnemy.attack);
        return;
    }
    
}

// =================================== //
//          SHOOT FUNCTION             //
// =================================== //

state_attack = function(){
    // player terdeksi -> pindah ke state shoot -> spawn bullet 
    
    if (!instance_exists(obj_player) || distance_to_object(obj_player) > distance_player * 1.2){
        change_state(stateEnemy.patrol);
        return;
    }
    
    target_x = obj_player.x;
    target_y = obj_player.y;
    
    if attack_cd <= 0{
        attack_cd =  attack_cd_max;
    
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

state_stun = function(){
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

// =================================== //
//          DEATH FUNCTION             //
// =================================== //

state_death = function(){
    // ke kill ->  death ->  ngasih buff -> destroy
    show_debug_message("state death");
    
    if (instance_exists(obj_player) && executed = true){
        with (obj_player){
            apply_buff(other.buff_type,other.buff_amount,other.buff_duration);
        }
    }
    instance_destroy();
}

//===========================================//
change_state = function(new_state){
    switch (state){
        case stateEnemy.stun:
            image_blend = c_white;
            break;
        case stateEnemy.attack:
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


get_stunned = function(duration){
    stun_duration = duration;
    change_state(stateEnemy.stun);
}




// state
enum stateEnemy{
    patrol,
    chase,
    attack,
    stun,
    execute,
    death
}

state = stateEnemy.patrol;
state_timer = 0;