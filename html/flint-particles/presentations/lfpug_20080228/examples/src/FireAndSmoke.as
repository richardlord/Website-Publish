
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
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import org.flintparticles.actions.*;
	import org.flintparticles.counters.*;
	import org.flintparticles.displayObjects.RadialDot;
	import org.flintparticles.emitters.*;
	import org.flintparticles.initializers.*;
	import org.flintparticles.zones.*;	

	public class FireAndSmoke extends Sprite
	{
		public function FireAndSmoke()
		{
			var emitter1:DisplayObjectEmitter = new DisplayObjectEmitter();
			emitter1.setCounter( new Steady( 55, 65 ) );

			emitter1.addInitializer( new Lifetime( 2, 3 ) );
			emitter1.addInitializer( new Velocity( new DiscSectorZone( new Point( 0, 0 ), 20, 10, -Math.PI, 0 ) ) );
			emitter1.addInitializer( new Position( new DiscZone( new Point( 0, 0 ), 3 ) ) );
			emitter1.addInitializer( new ImageClass( RadialDot, 5 ) );

			emitter1.addAction( new Age( ) );
			emitter1.addAction( new Move( ) );
			emitter1.addAction( new LinearDrag( 1 ) );
			emitter1.addAction( new Accelerate( 0, -40 ) );
			emitter1.addAction( new ColorChange( 0xFFFFCC00, 0x00CC0000 ) );
			emitter1.addAction( new Scale( 1, 1.5 ) );

			addChild( emitter1 );
			emitter1.x = 400;
			emitter1.y = 550;
			emitter1.start( );
			
			var emitter2:BitmapEmitter = new BitmapEmitter();
			
			emitter2.setCounter( new Steady( 8, 10 ) );
      
			emitter2.addInitializer( new Lifetime( 15, 17 ) );
			emitter2.addInitializer( new Velocity( new DiscSectorZone( new Point( 0, 0 ), 40, 30, -4 * Math.PI / 7, -3 * Math.PI / 7 ) ) );
			emitter2.addInitializer( new SharedImage( new RadialDot( 7 ) ) );
      
			emitter2.addAction( new Age( ) );
			emitter2.addAction( new Move( ) );
			emitter2.addAction( new LinearDrag( 0.01 ) );
			emitter2.addAction( new Scale( 1, 15 ) );
			emitter2.addAction( new Fade( 0.2, 0 ) );
			emitter2.addAction( new RandomDrift( 15, 15 ) );
			
			addChild( emitter2 );
			emitter2.x = 400;
			emitter2.y = 550;
			emitter2.start( );
		}
	}
}