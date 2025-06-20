move_spd = 1.2;
curr_spd = move_spd;
tilemap = layer_tilemap_get_id("tile_col");

player = obj_player_control;

damage = 1;
curr_dmg = damage;

facing = 0;
can_move = true;

//attack combo
is_attacking = false;
combo_timer = 0;
combo_timeout = 30;
combo_max= 3;
combo_count = 0;
can_combo = false;

//attack mana
mana_cost = 1;

//dash movement
can_dash = true;
is_dashing = false;
dash_spd = 2
dash_timer = 0;
dash_duration = 10;
dash_cd_timer = 0;
dash_direction = 0;

//defend
is_defend = false;


 //inventory
open_inventory = false;

// inventory position
inv_pos_x = 16;
inv_pos_y = 32;


// change mode

mode_slot = 2;
current_mode = playerMode.mode_mel;
selected_mode = playerMode.mode_mel;

//execution mode
is_execute = false;



//ui mode
mode_ui = true;

//change mode position
mode_pos_x = 280
mode_pos_y = 150

//buff environment

buff_active = false;
speed_buff = false;
damage_buff = false; 
health_buff = false;
buff_timer = 0;
buff_type = "";


//function



// ++++++++++++++++++ FUNCTION +++++++++++++++++++++++
// =================================================//
//                    BUFF FUNCTION                 //
// =================================================//
apply_buff = function(_type,_amount,_duration){
    switch(_type){
        case "health":
            obj_player_control.hp = min(obj_player_control.hp + _amount,obj_player_control.hp_total);
            break;
        case "speed":
            curr_spd = move_spd * _amount;
            break;
        case "attack":
            curr_dmg = damage * _amount;
            break;
        
    }
    
    buff_active = true;
    buff_timer = _duration;
    buff_type = _type;
    
    show_debug_message("buff : " + _type);
}



// =================================================//
//                   ATTACK FUNCTION                //
// =================================================//

player_attack = function(_attack_num){
    
    if(!is_attacking){
        is_attacking = true;
        can_combo = false;
    
     var _inst = instance_create_depth(x, y, 0, obj_sword_mask);
     _inst.image_angle = facing;
     _inst.combo_num = _attack_num;
        
     switch (_attack_num) {
        case 1:
            if (current_mode == 0){
                _inst.sprite_index = spr_slash;
                _inst.damage = damage;
            }else if (current_mode == 1){
                _inst.sprite_index = spr_magic1;
                _inst.damage = damage;
            }
            
            break;
        case 2:
            if (current_mode == 0){
                _inst.sprite_index = spr_slash2;
                _inst.damage = damage;
            }else if (current_mode == 1){
                _inst.sprite_index = spr_magic2;
                _inst.damage = damage;
            }
            break;
        case 3:
            if (current_mode == 0){
                _inst.sprite_index = spr_slash3;
                _inst.damage = damage;
            }else if (current_mode == 1){
                _inst.sprite_index = spr_magic3;
                _inst.damage = damage;
            }
            break;
    }
    alarm[0] = 10; //reset is_attacking
    alarm[1] = 2; //window combo
        
    }
    //show_debug_message("player attack " + string(_attack_num));
    //show_debug_message("state : " + string(state));
    

}

// =================================================//
//                  DASH FUNCTION                   //
// =================================================//

player_dash = function(){
   
    dash_timer--;
        
        var _dash_x = lengthdir_x(dash_spd,facing);
        var _dash_y = lengthdir_y(dash_spd,facing);
    
        move_and_collide(_dash_x, _dash_y, tilemap);
    
    if (dash_timer <= 0) {
            state = statePlayer.idle;
        }
    is_dashing = false;
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// =================================================//
//             IDLE FUNCTION + STATE                //
// =================================================//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
player_idle = function(_hor, _ver){
    
    

    
    //idle --> walk
    if (_hor != 0 || _ver != 0) {
        state = statePlayer.walk;
        exit; //
    }
    
    //sprite
    if( sprite_index == spr_walkDown) sprite_index = spr_idleDown;
    else if(sprite_index == spr_walkUp) sprite_index = spr_idleUp;
    else if(sprite_index == spr_walkRight) sprite_index = spr_idleRight;
    else if(sprite_index == spr_walkLeft) sprite_index = spr_idleLeft;
        
    //regen mana klo idle
    //mana_regen_timer ++;
    obj_player_control.mana_regen_timer ++;
        
        // cek timer ke delay
        if obj_player_control.mana_regen_timer >= obj_player_control.mana_regen_delay {
            // cek mana ga boleh lebih dari mana total
            if obj_player_control.mana < obj_player_control.mana_total {
                // formula regen mana
                obj_player_control.mana = min(obj_player_control.mana +obj_player_control.mana_regen_plus,obj_player_control.mana_total); 
                // min, mastiin biar nilai terkecil yang diambil 
            }
            obj_player_control.mana_regen_timer = 0;
        }
    
// =================================================//
//                TELEKINESIS EVENT                 //
// =================================================//
    if keyboard_check_pressed(ord("V")){
        show_debug_message("key pressed");
        var rock = instance_nearest(x,y,obj_rock); //cek collision
        
        
        // ada batu
        if rock != noone && !rock.thrown{
            var distance = distance_to_point(rock.x,rock.y);
            if distance <= 100{
                var nearest_enemy = instance_nearest(x,y,obj_enemy1);
            
                if nearest_enemy != noone{
                    rock.direction = point_direction(x,y,nearest_enemy.x,nearest_enemy.y); 
                    rock.rock_spd = 6;
                    rock.curr_distance = 0;
                    rock.thrown = true;
                    show_debug_message("Rock lempar : " + string(rock.direction));
                }
            }
            
        } else {
        	show_debug_message("no rock thrown");
        }
        
    }
    

// =================================================//
//                   DEFEND EVENT                   //
// =================================================//
    if(keyboard_check(ord("C"))){
        if !is_defend{
            is_defend = true;
            sprite_index = spr_defend;
            image_index = 0;
            show_debug_message("defend");
        } 
    }else {
        if is_defend{
            is_defend = false;
            sprite_index = spr_idleDown;
            show_debug_message("defend end")
            }
    }
    
// =================================================//
//                    DASH EVENT                    //
// =================================================//
     if (keyboard_check_pressed(vk_space) && state != statePlayer.dash && obj_player_control.mana >= mana_cost){
        obj_player_control.mana -= mana_cost;
        state = statePlayer.dash;
        dash_timer = dash_duration;
        dash_direction = point_direction(0,0,_hor,_ver);
        is_dashing = true;
    }
    
    
// =================================================//
//                   ATTACK EVENT                   //
// =================================================//
    if(mouse_check_button_pressed(mb_left) && !is_attacking && obj_player_control.mana >= mana_cost){
        show_debug_message("combo start : "+string(combo_count))
        obj_player_control.mana -= mana_cost;
        
        combo_count = (combo_count % combo_max) +1;
        //combo_count = clamp(combo_count,0,combo_max);
        combo_timer = combo_timeout;
        
        switch (combo_count) {
            case 1:
                if (current_mode == 0){
                    state = statePlayer.attack1;
                }else if(current_mode == 1){
                    state = statePlayer.magic1;
                }
                break;
            
            case 2:
                if (current_mode == 0){
                    state = statePlayer.attack2;
                }else if(current_mode == 1){
                    state = statePlayer.magic2;
                }
                break;
            
            case 3:
                if (current_mode == 0){
                    state = statePlayer.attack3;
                }else if(current_mode == 1){
                    state = statePlayer.magic3;
                }
                break;
        }
        
    }
    
}
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// =================================================//
//             WALK FUNCTION + STATE                //
// =================================================//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
player_walk = function(_hor, _ver){
    
    // walk --> idle
    if(_hor == 0 && _ver == 0){
        state = statePlayer.idle
        exit;
    }
    //formula move
    move_and_collide(_hor * move_spd, _ver * move_spd, tilemap);
    
    //sprrite
    if (_ver > 0 ) sprite_index = spr_walkDown;
    else if (_ver < 0 ) sprite_index = spr_walkUp;
    else if (_hor > 0 ) sprite_index = spr_walkRight;
    else if (_hor < 0 ) sprite_index = spr_walkLeft; 
    
    // mengsave point direction terakhirnya
    facing = point_direction(0,0,_hor,_ver);
    
    //reset mana
   obj_player_control.mana_regen_timer = 0;
    
// =================================================//
//                TELEKINESIS EVENT                 //
// =================================================//
    if keyboard_check_pressed(ord("V")){
        show_debug_message("key pressed");
        var rock = instance_nearest(x,y,obj_rock); //cek collision
        
        
        // ada batu
        if rock != noone && !rock.thrown{
            var distance = distance_to_point(rock.x,rock.y);
            if distance <= 100{
                var nearest_enemy = instance_nearest(x,y,obj_enemy1);
            
                if nearest_enemy != noone{
                    rock.direction = point_direction(x,y,nearest_enemy.x,nearest_enemy.y); 
                    rock.rock_spd = 6;
                    rock.curr_distance = 0;
                    rock.thrown = true;
                    show_debug_message("Rock lempar : " + string(rock.direction));
                }
            }
            
        } else {
        	show_debug_message("no rock thrown");
        }
        
        
    }
// =================================================//
//                    DASH EVENT                    //
// =================================================//
    if (keyboard_check_pressed(vk_space) && state != statePlayer.dash && obj_player_control.mana >= mana_cost){
        obj_player_control.mana -= mana_cost;
        state = statePlayer.dash;
        dash_timer = dash_duration;
        dash_direction = point_direction(0,0,_hor,_ver);
        is_dashing = true;
    }
    
// =================================================//
//                   ATTACK EVENT                   //
// =================================================//
    if(mouse_check_button_pressed(mb_left) && !is_attacking && obj_player_control.mana >= mana_cost){
        show_debug_message("combo start : "+string(combo_count))
            obj_player_control.mana -= mana_cost;
            
            combo_count = (combo_count % combo_max) +1;
            //combo_count = clamp(combo_count,0,combo_max);
            combo_timer = combo_timeout;
            
            switch (combo_count) {
                case 1:
                    if (current_mode == 0){
                        state = statePlayer.attack1;
                    }else if(current_mode == 1){
                        state = statePlayer.magic1;
                    }
                    break;
                
                case 2:
                    if (current_mode == 0){
                        state = statePlayer.attack2;
                    }else if(current_mode == 1){
                        state = statePlayer.magic2;
                    }
                    break;
                
                case 3:
                    if (current_mode == 0){
                        state = statePlayer.attack3;
                    }else if(current_mode == 1){
                        state = statePlayer.magic3;
                    }
                    break;
            }
            
        }
}








//state machine

enum statePlayer{
    idle,
    walk,
    attack1,
    attack2,
    attack3,
    dash,
    magic1,
    magic2,
    magic3,
    execute
}
enum playerMode{
    mode_mel,
    mode_mag
}
state = statePlayer.idle;