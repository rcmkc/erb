package objects;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;
import com.haxepunk.math.Vector;
import openfl.geom.Point;
import com.haxepunk.HXP;

/**
 * ...
 * @author Romko Pidstryhach

 */
class BaseBullet extends GameObject
{
	@:isVar public var speed(get, set) : Point;
	public function get_speed() : Point
	{
		return speed;
	}
	public function set_speed(v : Point) : Point
	{
		return speed = v;
	}
	
	public function new(image : Image = null) 
	{
		image.centerOrigin();
		
		super(0, 0, image);
		
		speed = new Point();
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (x > HXP.width || x < 0 || y > HXP.height || y < 0) 
		{
			destroy();
		}
		
		moveBy(speed.x * HXP.elapsed, speed.y * HXP.elapsed);
	}
	
	private function destroy()
	{
		level.recycle(this);
	}
}