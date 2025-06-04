target_x = x;
target_y = y;

alarm[0] = 60;

tilemap = layer_tilemap_get_id("tile_col");

kb_x = 0;
kb_y = 0

get_damage = false;
shoot_cd = 0;
shoot_cd_max = 50;

//cd = 50;
kejar = false;

is_stunned = false;
stun_duration =0;
move_spd = 0.5;

// state
enum stateEnemy{
    patrol,
    chase,
    shoot,
    stun,
    execute
}

state = stateEnemy.patrol;
state_timer = 0;