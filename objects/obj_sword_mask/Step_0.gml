x = obj_player.x
y = obj_player.y



if(image_index > image_number-1){
    instance_destroy();
}

var _inst = instance_place(x,y,obj_enemy_parent);

if _inst{
    
    if (_inst.armor > 0){
        _inst.hp -= 0.2;
        _inst.armor -= 1;
        
    }else{
         _inst.hp -= 1;
    }
    
   
    _inst.get_damage = true;
    _inst.alarm[1] = 20;
    
    instance_destroy();
}
