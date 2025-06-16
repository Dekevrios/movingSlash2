// ================================= //
//              WALK                 //
// ================================= //

if ( !can_move){
    var _hor = 0;
    var _ver = 0;
}else{
    var _hor = keyboard_check(ord("D")) - keyboard_check(ord("A"));
    var _ver = keyboard_check(ord("S")) - keyboard_check(ord("W"));
}


if (state == statePlayer.attack1 || state == statePlayer.attack2 || state == statePlayer.attack3) {
    player_attack(combo_count);
}
if (state == statePlayer.magic1 || state == statePlayer.magic2 || state == statePlayer.magic3) {
    player_attack(combo_count);
}

switch (state) {
    case statePlayer.idle:
        if current_mode == 0{
            player_idle(_hor, _ver);
        }else if current_mode == 1{
            player_idle(_hor, _ver);
        }
        
        break;
    
    case statePlayer.walk:
        player_walk(_hor, _ver);
        break;
    
    case statePlayer.attack1:
        player_attack(1);
        break;
    
    case statePlayer.attack2:
        player_attack(2);
        break;
    
    case statePlayer.attack3:
        player_attack(3);
        break;
    
    case statePlayer.dash:
        player_dash();
        break;
    
    case statePlayer.magic1:
        player_attack(1);
        break;
    
    case statePlayer.magic2:
        player_attack(2);
        break;
    
    case statePlayer.magic3:
        player_attack(3);
        break;
    case statePlayer.execute:
        
        break;
    
}


//=========================================//
//           BUFF ATRIBUTES MODE           //
//=========================================//


//function apply_buff(_type,_duration){
    //switch(_type){
       //
        //
    //}
//}



// event

//=========================================//
//         MODE SELECT AND INVENTORY       //
//=========================================//

if open_inventory = true{
    if keyboard_check_pressed(vk_right){
    
        if obj_player_control.inventory_slot  < 3{
            obj_player_control.inventory_slot++;
            inv_pos_x -= 16;
        }
        
    }
    if keyboard_check_pressed(vk_left){
        
        if obj_player_control.inventory_slot > 0{
            obj_player_control.inventory_slot--;
            inv_pos_x += 16;
        }

    }
}else if mode_ui {  // mode select
    
    //show_debug_message("Current mode: " + string(selected_mode))
    if keyboard_check_pressed(vk_right){
        
        if selected_mode  < 1{
            selected_mode++;
            mode_pos_x -= 16;
        }
        
    }
    if keyboard_check_pressed(vk_left){
        
        if selected_mode > 0{
            selected_mode--;
            mode_pos_x += 16;
        }

    }
    
    // cek selected_mode == apa?  ->  change sprite
    if (selected_mode != current_mode){
        current_mode = selected_mode;
        
        //mode_change();
        show_debug_message("Mode changed to: " + string(current_mode))
        return true;
    }
}

// =================================================//
//                    DASH EVENT                    //
// =================================================//

//if (keyboard_check_pressed(vk_space) && state != statePlayer.dash && obj_player_control.mana >= mana_cost){
    //obj_player_control.mana -= mana_cost;
    //state = statePlayer.dash;
    //dash_timer = dash_duration;
    //dash_direction = point_direction(0,0,_hor,_ver);
    //is_dashing = true;
//}

// =================================================//
//                TELEKINESIS EVENT                 //
// =================================================//

//if keyboard_check_pressed(ord("V")){
    //show_debug_message("key pressed");
    //var rock = instance_nearest(x,y,obj_rock); //cek collision
    //
    //
    //// ada batu
    //if rock != noone && !rock.thrown{
       //var distance = distance_to_point(rock.x,rock.y);
        //if distance <= 100{
            //var nearest_enemy = instance_nearest(x,y,obj_enemy1);
        //
        //
            //if nearest_enemy != noone{
                //rock.direction = point_direction(x,y,nearest_enemy.x,nearest_enemy.y); 
                //rock.rock_spd = 6;
                //rock.curr_distance = 0;
                //rock.thrown = true;
                //show_debug_message("Rock lempar : " + string(rock.direction));
            //}
        //}
        //
        //
    //} else {
    	//show_debug_message("no rock thrown");
    //}
    //
    //
//}

// =================================================//
//                   DEFEND EVENT                   //
// =================================================//

//if(keyboard_check(ord("C"))){
    //if !is_defend{
        //is_defend = true;
        //sprite_index = spr_defend;
        //image_index = 0;
        //show_debug_message("defend");
        //
    //} 
//}else {
    //if is_defend{
        //is_defend = false;
        //sprite_index = spr_idleDown;
        //show_debug_message("defend end")
        //}
//}


// =================================================//
//                   ATTACK EVENT                   //
// =================================================//

//if(mouse_check_button_pressed(mb_left) && !is_attacking && obj_player_control.mana >= mana_cost){
    //show_debug_message("combo start : "+string(combo_count))
        //obj_player_control.mana -= mana_cost;
        //
        //combo_count = (combo_count % combo_max) +1;
        ////combo_count = clamp(combo_count,0,combo_max);
        //combo_timer = combo_timeout;
        //
        //switch (combo_count) {
            //case 1:
                //if (current_mode == 0){
                    //state = statePlayer.attack1;
                //}else if(current_mode == 1){
                    //state = statePlayer.magic1;
                //}
                //break;
            //
            //case 2:
                //if (current_mode == 0){
                    //state = statePlayer.attack2;
                //}else if(current_mode == 1){
                    //state = statePlayer.magic2;
                //}
                //break;
            //
            //case 3:
                //if (current_mode == 0){
                    //state = statePlayer.attack3;
                //}else if(current_mode == 1){
                    //state = statePlayer.magic3;
                //}
                //break;
        //}
        //
    //}

// =================================================//
//                 EXECUTE EVENT                    //
// =================================================//

if (keyboard_check_pressed(ord("F")) && !is_execute){
    show_debug_message("f pressed");
    //pause game -> player move berubah -> tunggu selesai -> game jalan kembali
    var nearest_enemy = instance_nearest(x,y,obj_enemy_parent);
    
    if (nearest_enemy != noone && distance_to_object(nearest_enemy) < 40){
        show_debug_message("execute: " + string(nearest_enemy.can_execute));
     
        
        if (nearest_enemy.can_execute == true && nearest_enemy.armor <= 2){
            is_execute = true;
            instance_destroy(nearest_enemy);
            
            // efek
            var _execute = instance_create_depth(x,y,0,obj_sword_mask);
            _execute.image_angle = facing;
            _execute.sprite_index = spr_execute;
            
            can_move = false;
            show_debug_message("enemy executed");
            
            alarm[3] = 30;
        }
    }
    
}





// +++++++++++++++++++++++++++++ INVENTORY ++++++++++++++++++++++++++


// trigger inventory
if keyboard_check_pressed(ord("I")){

    if open_inventory = false{
        open_inventory = true;
    }
    else{
        open_inventory = false;
        inv_pos_x = 16;
        inv_pos_y = 32;
        obj_player_control.inventory_slot = 2;
    }
}
// ===========================
// LOGIC USE ITEM IN INVENTORY 
// ===========================

obj_player_control.inventory_slot = clamp(obj_player_control.inventory_slot,0,5);

if keyboard_check_pressed(ord("E")){ 
    if ds_list_find_value(obj_player_control.inventory, obj_player_control.inventory_slot) == "blue"{
       obj_player_control.blue -- ;
        obj_player_control.mana += 5;
    }
    if ds_list_find_value(obj_player_control.inventory,obj_player_control.inventory_slot) == "bomb"{
       obj_player_control.bomb--;
        show_debug_message("bomb terpakai");
    }
}
if ds_list_find_value(obj_player_control.inventory, obj_player_control.inventory_slot) == "blue"{
    if obj_player_control.blue <= 0{
        ds_list_delete(obj_player_control.inventory, ds_list_find_index(obj_player_control.inventory,"blue"))    
    }   
}
if ds_list_find_value(obj_player_control.inventory,obj_player_control.inventory_slot) =="bomb"{
    if obj_player_control.bomb <= 0{
        ds_list_delete(obj_player_control.inventory,ds_list_find_index(obj_player_control.inventory,"bomb"))
    }
}








// change mode

switch (current_mode) {
	case playerMode.mode_mel:
        
        break;
    
    case playerMode.mode_mag:
        
        break;
}


//show_debug_message("state : "+string(state));

