/*
 * Simple friction, remove drift when stopping
 */

class Ball extends MovieClip
{
	private var position:Vector;
	private var velocity:Vector;
	private var friction:Number;
	
	private var timer:Number;
	private var frameTime:Number;
	
	public function Ball()
	{
		position = new Vector( 300, 100 );
		velocity = new Vector( 300, -240 );
		friction = 150;
		
		timer = getTimer();

		draw();
	}
	
	public function get acceleration():Vector
	{
		if( velocity.length < friction * frameTime )
		{
			return velocity.minus().divide( frameTime );
		}
		else
		{
			return velocity.unit().minus().multiply( friction );
		}
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
		frameTime = ( timer - oldTimer ) / 1000;

		var oldVelocity:Vector = velocity.clone();
		velocity.addEq( acceleration.multiply( frameTime ) );
		var averageVel:Vector = oldVelocity.add( velocity ).divide( 2 );
		position.addEq( averageVel.multiply( frameTime ) );
		
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