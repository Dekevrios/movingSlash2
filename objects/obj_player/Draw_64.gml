// set ui size
display_set_gui_size(320,180);

// ==================================== //
//            UI INVENTORY              //
// ==================================== //

if open_inventory{
    draw_sprite(spr_inventory,0,inv_pos_x,inv_pos_y);
    for (i = 0;i < ds_list_size(obj_player_control.inventory); i++){
        
        // stack item
        if ds_list_find_value(obj_player_control.inventory, i) == "blue"{
            jumlah = obj_player_control.blue;
            i_index = 0;
        }
        
        if ds_list_find_value(obj_player_control.inventory, i) == "bomb"{
            jumlah = obj_player_control.bomb;
            i_index = 1;
        }
        
        // pasang icon di inventory
        if i < 4{ // i <  banyak slot
            draw_sprite(spr_consumable, i_index,inv_pos_x + ( 16 * i), 32)
            draw_text(inv_pos_x +(16 * i),32 - 8, jumlah);
        }
        
        
    }
    
    draw_sprite(spr_select,0,48,32);
    draw_text(0,0,$"{obj_player_control.inventory_slot} / {ds_list_find_value(obj_player_control.inventory,obj_player_control.inventory_slot)}")
    
}

// ==================================== //
//                UI MODE               //
// ==================================== //

draw_sprite(spr_mode,0,mode_pos_x,mode_pos_y);
draw_sprite(spr_select,0,280,mode_pos_y);

draw_set_color(c_blue);
draw_rectangle(16, 20, 16 + (obj_player_control.mana/ obj_player_control.mana_total * 200),30, false);
draw_set_color(c_white);

