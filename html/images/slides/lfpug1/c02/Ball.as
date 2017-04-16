/*
 * Compute new position after velocity
 */

class Ball extends MovieClip
{
	[Inspectable( name="Integrator", defaultValue="Implicit Euler", enumeration="Explicit Euler, Implicit Euler, Improved Euler, Runge Kutta, Verlet" )]
	private var integratorName:String;
	private var integrator:Function;
	
	private var position:Vector;
	private var velocity:Vector;
	private var friction:Number;
	
	private var pPosition:Vector;
	private var pVelocity:Vector;
	private var pFrameTime:Number;
	
	private var timer:Number;
	
	public function Ball()
	{
		var startX:Number;
		
		switch( integratorName )
		{
			case "Explicit Euler":
				integrator = updateExplicitEuler;
				startX = 100;
				break;
				
			case "Implicit Euler":
				integrator = updateImplicitEuler;
				startX = 200;
				break;
				
			case "Improved Euler":
				integrator = updateImprovedEuler;
				startX = 300;
				break;
				
			case "Runge Kutta":
				integrator = updateRungeKutta;
				startX = 400;
				break;
				
			case "Verlet":
				integrator = updateVerlet;
				startX = 500;
				break;
		}
		
		position = new Vector( startX, 100 );
		velocity = new Vector( 0, 300 );
		friction = 100;
		
		timer = getTimer();

		draw();
	}
	
	public function draw()
	{
		_x = position.x;
		_y = position.y;
	}
	
	public function getAcceleration( p:Vector, v:Vector, t:Number ):Vector
	{
		if( v.length < friction * t )
		{
			return v.minus().divide( t );
		}
		else
		{
			return v.unit().minus().multiply( friction );
		}
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

		integrator( frameTime );
		
		if( integratorName == "Verlet" )
		{
			if( position.x < 10 && pPosition.x > position.x )
			{
				pPosition.x = 2 * position.x - pPosition.x;
				velocity.x = -velocity.x;
			}
			if( position.x > 590 && pPosition.x < position.x )
			{
				pPosition.x = 2 * position.x - pPosition.x;
				velocity.x = -velocity.x;
			}
			if( position.y < 10 && pPosition.y > position.y )
			{
				pPosition.y = 2 * position.y - pPosition.y;
				velocity.y = -velocity.y;
			}
			if( position.y > 590 && pPosition.y < position.y )
			{
				pPosition.y = 2 * position.y - pPosition.y;
				velocity.y = -velocity.y;
			}
		}
		else
		{
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
		}
		
		draw();
	}
	
	public function updateExplicitEuler( frameTime:Number ):Void
	{
		var acceleration:Vector = getAcceleration( position, velocity, frameTime );
		position.addEq( velocity.multiply( frameTime ) );
		velocity.addEq( acceleration.multiply( frameTime ) );
	}
	
	public function updateImplicitEuler( frameTime:Number ):Void
	{
		var acceleration:Vector = getAcceleration( position, velocity, frameTime );
		velocity.addEq( acceleration.multiply( frameTime ) );
		position.addEq( velocity.multiply( frameTime ) );
	}
	
	public function updateImprovedEuler( frameTime:Number ):Void
	{
		var v1:Vector = velocity.clone();
		var p1:Vector = position.clone();
		var a1:Vector = getAcceleration( p1, v1, frameTime );
		
		var v2:Vector = v1.add( a1.multiply( frameTime ) );
		var p2:Vector = p1.add( v1.multiply( frameTime ) );
		var a2:Vector = getAcceleration( p2, v2, frameTime );
		
		velocity.addEq( a1.add( a2 ).multiply( frameTime / 2 ) );
		position.addEq( v1.add( v2 ).multiply( frameTime / 2 ) );
	}
	
	public function updateRungeKutta( frameTime:Number ):Void
	{
		var v1:Vector = velocity.clone();
		var p1:Vector = position.clone();
		var a1:Vector = getAcceleration( p1, v1, frameTime );
		
		var v2:Vector = v1.add( a1.multiply(  frameTime / 2 ) );
		var p2:Vector = p1.add( v1.multiply(  frameTime / 2 ) );
		var a2:Vector = getAcceleration( p2, v2, frameTime );
		
		var v3:Vector = v1.add( a2.multiply(  frameTime / 2 ) );
		var p3:Vector = p1.add( v2.multiply(  frameTime / 2 ) );
		var a3:Vector = getAcceleration( p3, v3, frameTime );

		var v4:Vector = v1.add( a3.multiply(  frameTime ) );
		var p4:Vector = p1.add( v3.multiply(  frameTime ) );
		var a4:Vector = getAcceleration( p4, v4, frameTime );
		
		position.addEq( v1.add( v2.multiply( 2 ) ).add( v3.multiply( 2 ) ).add( v4 ).multiply( frameTime / 6 ) );
		velocity.addEq( a1.add( a2.multiply( 2 ) ).add( a3.multiply( 2 ) ).add( a4 ).multiply( frameTime / 6 ) );
	}
	
	public function updateVerlet( frameTime:Number ):Void
	{
		if( pPosition == undefined )
		{
			pPosition = position.clone();
			pFrameTime = frameTime;
			updateImplicitEuler( frameTime );
			return;
		}
		
		var temp:Vector = position.clone();
		position.addEq( ( position.subtract( pPosition ).multiply( frameTime / pFrameTime ) ).add( getAcceleration( position, velocity, frameTime ).multiply( frameTime * frameTime ) ) );
		pPosition = temp;
		pFrameTime = frameTime;
		velocity = position.subtract( pPosition ).divide( frameTime );
	}
}