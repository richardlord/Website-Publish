
/*
 * FLINT PARTICLE SYSTEM
 * .....................
 * 
 * Author: Richard Lord
 * Copyright (c) Big Room Ventures Ltd. 2008
 * http://flintparticles.org/
 * 
 * Licence Agreement
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import org.flintparticles.actions.*;
	import org.flintparticles.counters.*;
	import org.flintparticles.emitters.*;
	import org.flintparticles.initializers.*;
	import org.flintparticles.zones.*;	

	public class Glimmer extends Sprite
	{
		[Embed(source="flint2.png")]
		public var Logo:Class;
		
		[Embed(source="sparkle.swf",symbol="Sparkle")]
		public var Sparkle:Class;

		public function Glimmer()
		{
			var bitmap:Bitmap = new Logo();
			addChild( bitmap );
			bitmap.x = 60;
			bitmap.y = 200;

			var emitter:BitmapEmitter = new BitmapEmitter();

			emitter.setCounter( new Steady( 5 ) );
			
			emitter.addInitializer( new ImageClass( Sparkle ) );
			emitter.addInitializer( new Lifetime( 1, 2 ) );
			emitter.addInitializer( new Position( new BitmapDataZone( bitmap.bitmapData, 0, 0 ) ) );
			emitter.addInitializer( new RotateVelocity( 3 ) );
			
			emitter.addAction( new Age() );
			emitter.addAction( new Fade( 1.0, 0 ) );
			emitter.addAction( new Rotate() );

			addChild( emitter );
			emitter.x = 60;
			emitter.y = 200;
			emitter.start( );
		}
	}
}