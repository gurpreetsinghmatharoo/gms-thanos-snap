/*
******************
sprite_getpixel
    --by matharoo
******************

Use this asset to get a color from a pixel inside a sprite.

**************************USAGE**************************

--GETPIXEL--

You can use sprite_getpixel() to get a pixel's color from a sprite.
The arguments are (sprite, subimg, x, y), where (x, y) is the position
of the pixel inside the sprite (so, "0, 0" would be the top-left corner).

It returns an array with values in the 0-255 range. In the array,

[0] is the red value 
[1] is the green value
[2] is the blue value
[3] is the alpha value

You can use make_color_rgb() to make a color variable using these values:

    var arr = sprite_getpixel(sBoi, 0, 2, 4);
    
    var color = make_color_rgb(arr[0], arr[1], arr[2]);
    var alpha = arr[3]/255;
    
Note that the alpha is divided by 255 to convert it from the 0-255 range
to the 0-1 range, used by GM's draw functions.

--IMPORTANT--

If you like my work, please consider buying one of my paid assets to help support me,
so that I can keep working on making GameMaker better for the community.

https://marketplace.yoyogames.com/publishers/3732/gurpreet-singh-matharoo

Much thanks!

*/
