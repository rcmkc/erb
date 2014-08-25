package ;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Romko Pidstryhach

 */
class G
{
	public static var MaxSpeed     : Float = 500.0;//300.0;
	public static var Acceleration : Float = 50.0;//30.0;
	public static var Friction     : Float = .9;
	public static var BulletSpeed  : Float = 500.0;
	
	public static var PlanesNumber : Int   = 64;
	public static var KeyNumber    : Int   = 16;
	
	public static var MaxRadius    : Int   = 512;
	
	public static var ChaserSpeed : Float = 400.0;
	public static var ChaserAcceleration : Float = 40.0;
	
	public static var FlockDistance : Float = 100.0;
	
	
	public static var Bounds : Rectangle = new Rectangle(0, 0, 640, 480);
}