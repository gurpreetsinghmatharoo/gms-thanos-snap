/// @description 
show_debug_overlay(1)

// Shader Uniforms
uniUvs = shader_get_uniform(shNoFeelGood, "uvs");
uniVal = shader_get_uniform(shNoFeelGood, "val");
uniCol = shader_get_uniform(shNoFeelGood, "fadeCol");
uniSpread = shader_get_uniform(shNoFeelGood, "spread");

uniTexUvs = shader_get_uniform(shNoFeelGood, "texUvs");
uniTex = shader_get_sampler_index(shNoFeelGood, "tex");

// Don't feel so good
animVal = 0.2; // Animation progress, from 0-1
animSpeed = sprite_width / 60000; // Animation speed
animSpread = 0.12; // How much the effect is spread out / feathered

animStart = false; // Whether the animation has been started

animPartInterval = 0.01; // Interval for creating particles
animPartLast = 0; // Last time when particles were created

// Particles
partSys = part_system_create();

partDust = part_type_create(); // Create dust particle
part_type_sprite(partDust, sPartDust, 0, 0, 0);
part_type_color1(partDust, fadeColor);
part_type_speed(partDust, 0.15, 0.28, 0, 0.01);
part_type_direction(partDust, 35, 70, 0.1, 8);
part_type_alpha2(partDust, 1, 0);
part_type_life(partDust, 80, 140);

//	 DISABLED
// Pattern array
// In a 2D array, stores the value of each pixel of the pattern
//pattern = [];

//var _spr = sPattern;
//var _w = sprite_get_width(_spr);
//var _h = sprite_get_height(_spr);

//for (var _x = 0; _x < _w; _x++) {
//	for (var _y = 0; _y < _h; _y++) {
//		var _col = sprite_getpixel(_spr, 0, _x, _y);
		
//		pattern[_x, _y] = _col[0] / 255;
//	}
//}

//patternW = _w;
//patternH = _h;

// Alpha array
// In a 2D array, stores the alpha of each pixel of the sprite
alpha = [];

var _spr = sprite_index;
var _w = sprite_width;
var _h = sprite_height;

for (var _x = 0; _x < _w; _x++) {
	for (var _y = 0; _y < _h; _y++) {
		var _col = sprite_getpixel(_spr, 0, _x, _y);
		
		alpha[_x, _y] = _col[3];
	}
}