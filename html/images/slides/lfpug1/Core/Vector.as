class Vector
{
	public var x:Number;
	public var y:Number;
	
	public function Vector( sx:Number, sy:Number )
	{
		x = sx;
		y = sy;
	}
	
	public static function zero():Vector
	{
		return new Vector( 0, 0 );
	}
	
/**
 * Copy
 */
	public function clone():Vector
	{
		return new Vector( x, y );
	}
	
/**
 * Basic Mathematics
 */
	public function add( v:Vector ):Vector
	{
		return new Vector( x + v.x, y + v.y );
	}
	public function subtract( v:Vector ):Vector
	{
		return new Vector( x - v.x, y - v.y );
	}
	public function multiply( n:Number ):Vector
	{
		return new Vector( x * n, y * n );
	}
	public function divide( n:Number ):Vector
	{
		return multiply( 1 / n );
	}

	public function addEq( v:Vector ):Vector
	{
		x += v.x;
		y += v.y;
		return this;
	}
	public function subtractEq( v:Vector ):Vector
	{
		x -= v.x;
		y -= v.y;
		return this;
	}
	public function multiplyEq( n:Number ):Vector
	{
		x *= n;
		y *= n;
		return this;
	}
	public function divideEq( n:Number ):Vector
	{
		return multiplyEq( 1 / n );
	}

/**
 * Vector Mathematics
 */
	public function get length():Number
	{
		return Math.sqrt( x * x + y * y );
	}
	
/**
 * Create new from this
 */
	public function minus():Vector
	{
		return new Vector( -x, -y );
	}
	public function unit():Vector
	{
		var s:Number = length;
		if( s != 0 )
		{
			return divide( s );
		}
		else
		{
			return null;
		}
	}
	
/**
 * Debugging
 */
	public function toString():String
	{
		return "(x=" + x + ", y=" + y + ")";
	}
}