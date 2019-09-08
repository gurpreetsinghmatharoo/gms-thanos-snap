/// @description  sprite_getpixel(sprite, subimg, x, y);
/// @function  sprite_getpixel
/// @param  sprite
/// @param  subimg
/// @param  x
/// @param  y
// Returns an array with the color info of a pixel inside a sprite
var _sprite = argument0;
var _subimg = argument1;
var _x = argument2;
var _y = argument3;

//Important vars
var sprW = sprite_get_width(_sprite);
var sprH = sprite_get_height(_sprite);
var sprX = sprite_get_xoffset(_sprite);
var sprY = sprite_get_yoffset(_sprite);

//Check if buffer already exists
var exists = 0;
//0 = doesn't exist
//1 = sprite array exists
//2 = subimg element exists

var key = string(_sprite);

if (ds_map_exists(global.sprBuff, key)){
    var arr = global.sprBuff[? key];
    
    exists = 1;
    
    if (array_length_1d(arr) > _subimg && buffer_exists(arr[_subimg])){
        exists = 2;
    }
}

//Create sprite array
if (exists == 0){
    var arr = array_create(_subimg + 1);
    
    for(var i=0; i<_subimg+1; i++){
        arr[i] = -1;
    }
    
    global.sprBuff[? key] = arr;
    
    exists = 1;
}

//Create buffer
if (exists == 1){
    var arr = global.sprBuff[? key];
    
    var buff = buffer_create(4 * sprW * sprH, buffer_fixed, 1);
    arr[@ _subimg] = buff;
    
    var surf = surface_create(sprW, sprH);
    
    surface_set_target(surf);
    
    draw_clear_alpha(c_white, 0);
    
    gpu_set_blendmode_ext(bm_one, bm_zero);
    
    draw_sprite(_sprite, _subimg, sprX, sprY);
    
    gpu_set_blendmode(bm_normal);
    
    surface_reset_target();
    
    buffer_get_surface(arr[_subimg], surf, 0, 0, 0);
    
    surface_free(surf);
    
    exists = 2;
}

//Get pixel
if (exists == 2){
    var arr = global.sprBuff[? key];
    var buff = arr[_subimg];
    
    buffer_seek(buff, buffer_seek_start, 4*((sprW*_y)+_x));
    
    var clr;
    clr[0] = buffer_read(buff, buffer_u8);
    clr[1] = buffer_read(buff, buffer_u8);
    clr[2] = buffer_read(buff, buffer_u8);
    clr[3] = buffer_read(buff, buffer_u8);
    
    return clr;
}
