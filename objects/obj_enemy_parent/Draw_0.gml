if(get_damage = true ){
    var rgb = make_color_hsv(0,0,255);
     draw_set_color(rgb);
    //draw_sprite_ext(sprite_index, image_index,x,y,1,1,0,rgb,1);
    draw_self();
}
else{
    draw_set_color(c_white);
    draw_self();   
}

draw_text(x+5,y,hp)

draw_text(x+5 ,y-22 ,armor);

