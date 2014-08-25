package objects;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;
import com.haxepunk.HXP;
/**
 * ...
 * @author Romko Pidstryhach

 */
class NavigationArrow extends Entity
{
	private var _image : Image;
	private var _target : Entity;
	
	@:isVar public var angle : Float;
	public function get_angle() : Float
	{
		return angle;
	}
	public function set_angle(v : Float) : Float
	{
		return angle = v;
	}
	
	public function new(target : Entity) 
	{
		_image = new Image("graphics/arrow.png");
		_image.originY = _image.height * 0.5;
		_image.scrollX = 0.0;
		_image.scrollY = 0.0;
		//_image.alpha   = 0.8;
		
		_target = target;
		
		if (Std.is(_target, Portal)) 
		{
			_image.color = 0x0;
		}
		else if (Std.is(_target, Enemy))
		{
			_image.color = 0xFF5353;
			_image.originX = 16;
		}
		else
		{
			_image.color = 0x8BFF53;
			_image.originX = 32;
		}
		
		super(320, 240, _image);
	}
	
	override public function update():Void 
	{
		super.update();
		_image.angle = HXP.angle(HXP.camera.x + 320, HXP.camera.y + 240, _target.x, _target.y);
		
		var distance : Float = HXP.distance(HXP.camera.x + 320, HXP.camera.y + 240, _target.x, _target.y);
		
		if (distance < 300) 
		{
			_image.alpha = HXP.scaleClamp(distance, 150.0, 300.0, 0.0, 0.5);
		}
	}
	
}