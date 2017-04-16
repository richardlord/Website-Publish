/*
 * Simple movement with timer
 */

class Ball extends MovieClip
{
	private var position:Vector;
	private var velocity:Vector;
	
	private var timer:Number;
	
	public function Ball()
	{
		position = new Vector( 300, 100 );
		velocity = new Vector( 300, -240 );
		
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
		
		draw();
	}
}