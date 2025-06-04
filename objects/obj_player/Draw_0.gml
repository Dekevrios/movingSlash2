
draw_text(x,y+2,obj_player_control.hp)

if (is_dashing) {
    draw_text(x, y-20, "IMMUNE!");
}

if (current_mode == 1){
    
    image_alpha = 0.7;
    image_blend = c_blue;
    
    
    draw_set_color(c_white);
    
}else if(current_mode == 0){
    image_alpha = 1;
    image_blend = c_white;
  
}
draw_self();
