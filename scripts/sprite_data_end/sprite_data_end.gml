/// sprite_data_end()
// Deletes all data required for sprite_getpixel

//Delete all buffers
for(var i=0; i<ds_map_size(global.sprBuff); i++){
    var arr = global.sprBuff[? i];
    
    for(var j=0; j<array_length_1d(arr); j++){
        if (buffer_exists(arr[j])){
            buffer_delete(arr[j]);
        }
    }
}

//Delete map
ds_map_destroy(global.sprBuff);