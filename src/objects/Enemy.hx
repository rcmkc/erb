package objects;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;
import com.haxepunk.HXP;
import openfl.geom.Point;

/**
 * ...
 * @author Romko Pidstryhach

 */
class Enemy extends GameObject
{	
	@:isVar public var target(get, null) : Player;
	public function get_target() : Player
	{
		return target;
	}
	
	@:isVar public var speed(get, set) : Point;
	public function get_speed() : Point
	{
		return speed;
	}
	public function set_speed(v : Point) : Point
	{
		return speed = v;
	}
	
	private var _arrow : NavigationArrow;
	
	public function new(graphic : Graphic, target : Player) 
	{
		this.target = target;
		
		speed = new Point();
		
		var distance : Int   = Std.int(G.MaxRadius * HXP.random);
		var angle    : Float = 360.0 * HXP.random;
		
		var position : Point = new Point();
		
		HXP.angleXY(position, angle, distance);
		
		super(position.x, position.y, graphic);
		
		type = "enemy";
	}
	
	override public function added():Void 
	{
		super.added();
		level.add(_arrow = new NavigationArrow(this));
	}
	
	override public function removed():Void 
	{
		super.removed();
		level.remove(_arrow);
		_arrow = null;
	}
}