/*
 * Spring motion
 */

class Ball extends MovieClip
{
	private var position:Vector;
	private var velocity:Vector;
	private var centre:Vector;
	private var pull:Number;
	private var friction:Number;
	
	private var frameTime:Number;
	private var timer:Number;
	
	public function Ball()
	{
		position = new Vector( 300, 150 );
		velocity = new Vector( 0, 300 );
		centre = new Vector( 300, 300 );
		pull = 10;
		friction = 150;
		
		timer = getTimer();

		draw();
	}
	
	public function get acceleration():Vector
	{
		var a:Vector, b:Vector;
		a = centre.subtract( position ).multiply( pull );
		
		if( velocity.length < friction * frameTime )
		{
			b = velocity.minus().divide( frameTime );
		}
		else
		{
			b = velocity.unit().minus().multiply( friction );
		}
		return a.add( b );
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