package objects;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

/**
 * ...
 * @author Romko Pidstryhach

 */
class Bullet extends BaseBullet
{
	private var _image : Image;
	private var _angle : Float;
	
	public function new() 
	{
		_image = Image.createCircle(2, 0xD9FFE9);
		_image.scaleX = 5;
		
		super(_image);
	}
	
	public function spawn(x : Float, y : Float, angle : Float, velocity : Float) : Entity
	{
		this.x = x;
		this.y = y;
		
		_angle = angle;
		
		HXP.angleXY(speed, _angle, velocity);
		
		return this;
	}
	
	override public function update():Void 
	{
		super.update();
		
		_image.angle = _angle;
	}
}