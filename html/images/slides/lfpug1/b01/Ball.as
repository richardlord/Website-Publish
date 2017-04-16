/*
 * Simple movement
 */

class Ball extends MovieClip
{
	private var velocity_x:Number;
	private var velocity_y:Number;
	
	public function Ball()
	{
		_x = 300;
		_y = 100;
		
		velocity_x = 10;
		velocity_y = -8;
	}
	
	public function onEnterFrame():Void
	{
		_x += velocity_x;
		_y += velocity_y;
	}
}