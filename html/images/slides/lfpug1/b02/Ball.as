/*
 * Simple movement using vectors
 */

class Ball extends MovieClip
{
	private var position:Vector;
	private var velocity:Vector;
	
	public function Ball()
	{
		position = new Vector( 300, 100 );
		velocity = new Vector( 10, -8 );

		draw();
	}
	
	public function draw()
	{
		_x = position.x;
		_y = position.y;
	}
	
	public function onEnterFrame():Void
	{
		position.addEq( velocity );
		
		draw();
	}
}