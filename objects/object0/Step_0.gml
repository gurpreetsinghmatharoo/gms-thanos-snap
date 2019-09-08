/// @description 
// Restart
if (keyboard_check_pressed(ord("R"))) {
	room_restart();
}

// Start animation with S
if (!animStart && keyboard_check_pressed(ord("S"))) {
	animStart = true;
}


// Animation started
if (animStart) {
	// Animation progress value
	if (animVal < 1) animVal += animSpeed;
	else animVal = 1;

	// Create particles, if interval met
	if (animVal - animPartLast > animPartInterval) {
		// Get top-left coordinate of instance
		var _xBase = x - sprite_get_xoffset(sprite_index);
		var _yBase = y - sprite_get_yoffset(sprite_index);
		
		// Vars
		var _iMargin = 0; // Margins for diagonal line
		var _incr = 0.02; // Distance between each point on the diagonal line

		// Animation value where particles should be created
		var _endVal = clamp(animVal - animSpread, 0, 1) * 2;
		
		// Set margin if animation is more than halfway through
		if (_endVal >= 1) _iMargin = (_endVal - 1) / 2;
		
		// Run loop for diagonal line
		for (var i=_iMargin; i<1 - _iMargin; i+=_incr) {
			// Get relative position (0-1)
			var _xRel = _endVal * i;
			var _yRel = _endVal * (1 - i);
			
			// Clamp
			_xRel = clamp(_xRel, 0, 0.99);
			_yRel = clamp(_yRel, 0, 0.99);
		
			// Absolute position in sprite
			var _xAb = _xRel * sprite_width;
			var _yAb = _yRel * sprite_height;
		
			// Skip if alpha is 0
			if (alpha[floor(_xAb), floor(_yAb)] <= 0) continue;
		
			// Absolute position in room
			var _x = _xBase + _xAb;
			var _y = _yBase + _yAb;
		
			//	 DISABLED
			// Pattern offset
			//var _off = 0.5;
			//_x += pattern[floor(patternW * _xRel)] * _off;
			//_y += pattern[floor(patternH * _yRel)] * _off;
	
			// Create particle
			part_particles_create(partSys, _x, _y, partDust, 1);
		}
		
		// Set last anim time
		animPartLast = animVal;
	}
}