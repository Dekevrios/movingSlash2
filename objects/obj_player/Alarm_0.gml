
is_attacking = false;
if (state == statePlayer.attack1 || state == statePlayer.attack2 || state == statePlayer.attack3 || 
    state == statePlayer.magic1 || state == statePlayer.magic2 || state == statePlayer.magic3) {
    state = statePlayer.idle;
}