shader_type particles;
//render_mode disable_velocity;
//render_mode keep_data;

uniform vec2 target_position = vec2( -1.0, -1.0 );

float rand_from_seed(inout uint seed) {
	int k;
	int s = int(seed);
	if (s == 0)
	s = 305420679;
	k = s / 127773;
	s = 16807 * (s - k * 127773) - 2836 * k;
	if (s < 0)
		s += 2147483647;
	seed = uint(s);
	return float(seed % uint(65536)) / 65535.0;
}


uint hash(uint x) {
	x = ((x >> uint(16)) ^ x) * uint(73244475);
	x = ((x >> uint(16)) ^ x) * uint(73244475);
	x = (x >> uint(16)) ^ x;
	return x;
}









void start() 
{
	uint base_number = NUMBER;
	uint alt_seed = hash(base_number + uint(1) + RANDOM_SEED);
	
	//TRANSFORM = EMISSION_TRANSFORM;
	float r = rand_from_seed( alt_seed ) * 30.0;
	float a = rand_from_seed( alt_seed ) * 6.3;
	//TRANSFORM[3].xy = vec2( 320.0 * rand_from_seed( alt_seed ), 180.0 * rand_from_seed( alt_seed ) );
	TRANSFORM[3].xy = vec2(
		160.0 + r * cos( a ), 90.0 + r * sin( a )
	);
	
	if( rand_from_seed( alt_seed ) > 0.5 )
		TRANSFORM[0].x = -abs( TRANSFORM[0].x );
	
	CUSTOM.x = 0.0;
	CUSTOM.y = 2.0 + rand_from_seed( alt_seed ) * 2.0;
	CUSTOM.z = 0.0;
	VELOCITY *= 0.0;
}

void process() 
{
	uint base_number = NUMBER;
	uint alt_seed = hash(base_number + uint(1) + RANDOM_SEED);
	//TRANSFORM[3].x += DELTA * 0.5;
	
	// Control frame
	if( CUSTOM.x < 0.1 )
	{
		// animation
		CUSTOM.z += 0.25 * DELTA;
		if( CUSTOM.z > 3.0 / 20.0 ) CUSTOM.z = 0.0;
		// timer
		CUSTOM.y -= DELTA;
		if( CUSTOM.y <= 0.0 )
		{
			CUSTOM.x = 1.0; // state
			CUSTOM.y = 3.0 + rand_from_seed( alt_seed ) * 3.0;
			CUSTOM.z = 4.1 / 20.0; // animation
			VELOCITY *= 0.0;
		}
	}
	if( CUSTOM.x > 0.9 && CUSTOM.x < 1.1 )
	{
		// animation
		CUSTOM.z += 0.25 * DELTA;
		if( CUSTOM.z > 7.0 / 20.0 ) CUSTOM.z = 4.1 / 20.0;
		// timer
		CUSTOM.y -= DELTA;
		if( CUSTOM.y <= 0.0 )
		{
			if( rand_from_seed( alt_seed ) < 0.0 )
			{
				CUSTOM.x = 0.0; // state
				CUSTOM.y = 3.0 + rand_from_seed( alt_seed ) * 3.0;
				CUSTOM.z = 4.1 / 20.0; // animation
				VELOCITY *= 0.0;
			}
			else
			{
				CUSTOM.x = 2.0; // state
				CUSTOM.y = 1.0 + rand_from_seed( alt_seed ) * 1.0;
				CUSTOM.z = 14.1 / 20.0; // animation
				vec2 target = vec2( 320.0 * rand_from_seed( alt_seed ), 180.0 * rand_from_seed( alt_seed ) );
				vec2 dist = target - TRANSFORM[3].xy;
				VELOCITY.xy = normalize( dist ) * ( 15.0 + rand_from_seed( alt_seed ) * 10.0 );
				//VELOCITY.xy = vec2( 
					//rand_from_seed( alt_seed ) - 0.5,
					//rand_from_seed( alt_seed ) - 0.5 ) * 40.0;
				if( VELOCITY.x > 0.0 )
				{
					TRANSFORM[0].x = abs( TRANSFORM[0].x );
				}
				else if( VELOCITY.x < 0.0 )
				{
					TRANSFORM[0].x = -abs( TRANSFORM[0].x );
				}
			}
		}
	}
	if( CUSTOM.x > 1.9 && CUSTOM.x < 2.1 )
	{
		// animation
		CUSTOM.z += 0.5 * DELTA;
		if( CUSTOM.z > 20.0 / 20.0 ) CUSTOM.z = 14.1 / 20.0;
		// timer
		CUSTOM.y -= DELTA;
		if( CUSTOM.y <= 0.0 )
		{
			if( rand_from_seed( alt_seed ) < 0.5 )
			{
				CUSTOM.x = 0.0; // state
				CUSTOM.y = 1.0 + rand_from_seed( alt_seed ) + 1.0;
				CUSTOM.z = 0.1 / 20.0; // animation
				VELOCITY *= 0.0;
			}
			else
			{
				CUSTOM.x = 1.0; // state
				CUSTOM.y = 1.0 + rand_from_seed( alt_seed ) + 1.0;
				CUSTOM.z = 4.1 / 20.0; // animation
				VELOCITY *= 0.0;
			}
		}
		
	}
}

