move_spd = 1.2;
tilemap = layer_tilemap_get_id("tile_col");

player = obj_player_control;

damage = 1;

facing = 0;

//attack combo
is_attacking = false;
combo_timer = 0;
combo_timeout = 30;
combo_max= 3;
combo_count = 0;
can_combo = false;

//attack combo revisi
a_combo[0] = spr_slash;
a_combo[1] = spr_slash2
a_combo[2] = spr_slash3

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