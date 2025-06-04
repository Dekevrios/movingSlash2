// set collision enter 

if place_meeting(x,y, obj_player){
    show_debug_message("item diambil")
    instance_destroy();
    
    // mencari index dan mengatur max size
    if ds_list_find_index(obj_player_control.inventory, nama[image_index]) < 0{
        if ds_list_size(obj_player_control.inventory) < 3{
            ds_list_add(obj_player_control.inventory,nama[image_index]);
        }
    }
    
    if image_index = 0{
        obj_player_control.blue ++;
    }
    if image_index = 1{
        obj_player_control.bomb ++;
    }
    
}