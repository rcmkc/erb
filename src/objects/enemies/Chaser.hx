package objects.enemies;
import com.haxepunk.graphics.Image;
import com.haxepunk.math.Vector;
import openfl.geom.Point;
import com.haxepunk.HXP;
/**
 * ...
 * @author Romko Pidstryhach

 */
class Chaser extends Enemy
{
	private var _image : Image;
	private var _acceleration : Point;
	
	public function new(target : Player) 
	{
		_image = Image.createCircle(5, 0x182521);
		_image.scaleX = 2;
		_image.centerOrigin();
		//_image.alpha = 0.5;
		_acceleration = new Point();
		
		super(_image, target);
		
		speed.x = HXP.rand(10) - 5; 
		speed.y = HXP.rand(10) - 5; 
		
		setHitbox(10, 10, 5, 5);
	}
	
	override public function update():Void 
	{
		var angle : Float = HXP.angle(x, y, target.x , target.y );
		
		_image.angle = HXP.angle(0, 0, speed.x, speed.y);
		
		/*if (!target.invisible) 
		{
			HXP.angleXY(_acceleration, angle, G.ChaserAcceleration);
		
			speed.x += _acceleration.x;
			speed.y += _acceleration.y;
			
			speed.normalize(G.ChaserSpeed);
			
			moveBy(speed.x * HXP.elapsed, speed.y * HXP.elapsed);
		}*/
		//else
		//{
			moveBy(speed.x, speed.y);
		//}
		
		
		
		super.update();
	}
}