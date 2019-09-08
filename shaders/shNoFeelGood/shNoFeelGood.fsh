//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// Uniforms
uniform vec4 uvs; // Base texture UVs
uniform float val; // Animation progress (0-1)

uniform vec3 fadeCol; // Dust color

uniform float spread; // Feathering

// Pattern sampler
uniform sampler2D tex; // Pattern texture
uniform vec4 texUvs; // Pattern UVs

void main()
{
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	// Normalize coords
	vec2 coords = v_vTexcoord;
	
	coords = (coords - uvs.xy) / (uvs.zw - uvs.xy);
	
	// Value from pattern
	vec2 patCoords = texUvs.xy + coords * (texUvs.zw - texUvs.xy);
	float patVal = texture2D(tex, patCoords).r;
	
	// Pixel index
	float pIndex = (coords.x + coords.y) / 2.;
	pIndex += patVal * spread * 2.;
	
	// Value for this pixel
	float pBase = pIndex - spread;
	float valRel = max(0.0, val - pBase);
	float pVal = min(1.0, valRel / spread);
	
	// Fade to color
	gl_FragColor.rgb = mix(gl_FragColor.rgb, fadeCol, pVal);
	
	// Alpha
	gl_FragColor.a *= 1. - floor(pVal);
}
