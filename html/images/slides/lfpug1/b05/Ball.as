/*
 * Simple acceleration - gravity
 */

class Ball extends MovieClip
{
	private var position:Vector;
	private var velocity:Vector;
	private var acceleration:Vector;
	
	private var timer:Number;

	public function Ball()
	{
		position = new Vector( 300, 200 );
		velocity = new Vector( 300, -240 );
		acceleration = new Vector( 0, 1800 );
		
		timer = getTimer();

		draw();
	}
	
	public function draw()
	{
		_x = position.x;
		_y = position.y;
	}
	
	public function onEnterFrame():Void
	{
		var oldTimer:Number = timer;
		timer = getTimer();
		var frameTime:Number = ( timer - oldTimer ) / 1000;
		if( frameTime > 0.1 )
		{
			return;
		}

		position.addEq( velocity.multiply( frameTime ) );
		velocity.addEq( acceleration.multiply( frameTime ) );
		
		if( position.x < 10 && velocity.x < 0 )
		{
			velocity.x = -velocity.x;
		}
		if( position.x > 590 && velocity.x > 0 )
		{
			velocity.x = -velocity.x;
		}
		if( position.y < 10 && velocity.y < 0 )
		{
			velocity.y = -velocity.y;
		}
		if( position.y > 590 && velocity.y > 0 )
		{
			velocity.y = -velocity.y;
		}
		
		draw();
	}
}