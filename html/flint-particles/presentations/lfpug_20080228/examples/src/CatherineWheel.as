
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
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	
	import org.flintparticles.actions.*;
	import org.flintparticles.activities.*;
	import org.flintparticles.counters.*;
	import org.flintparticles.displayObjects.Line;
	import org.flintparticles.emitters.*;
	import org.flintparticles.energyEasing.Quadratic;
	import org.flintparticles.initializers.*;
	import org.flintparticles.zones.*;	

	public class CatherineWheel extends Sprite
	{
		public function CatherineWheel()
		{
			var emitter:BitmapEmitter = new BitmapEmitter();

			emitter.addFilter( new BlurFilter( 2, 2, 1 ) );
			emitter.addFilter( new ColorMatrixFilter( [ 1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0.97,0 ] ) );

			emitter.setCounter( new Steady( 250 ) );
			
			emitter.addActivity( new RotateEmitter( -7 ) );
			
			emitter.addInitializer( new SharedImage( new Line( 3 ) ) );
			emitter.addInitializer( new ColorInit( 0xFFFFFF00, 0xFFFF6600 ) );
			emitter.addInitializer( new Velocity( new DiscSectorZone( new Point( 0, 0 ), 200, 350, 0, 0.2 ) ) );
			emitter.addInitializer( new Lifetime( 2 ) );
			
			emitter.addAction( new Age( Quadratic.easeIn ) );
			emitter.addAction( new Move() );
			emitter.addAction( new Fade() );
			emitter.addAction( new Accelerate( 0, 50 ) );
			emitter.addAction( new LinearDrag( 0.5 ) );
			
			addChild( emitter );
			emitter.x = 400;
			emitter.y = 300;
			emitter.start( );
		}
	}
}