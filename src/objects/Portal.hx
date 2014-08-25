package objects;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;
import com.haxepunk.math.Vector;
import com.haxepunk.Sfx;
import com.haxepunk.utils.Ease;
import com.haxepunk.HXP;
import common.Plane;
import openfl.geom.Point;

/**
 * ...
 * @author Romko Pidstryhach

 */
class Portal extends GameObject
{
	private var _image   : Image;
	private var _emitter : Emitter;
	
	@:isVar public var target(get,set) : Plane;
	public function get_target() : Plane
	{
		return target;
	}
	public function set_target(v : Plane) : Plane
	{
		return target = v;
	}
	
	@:isVar public var plane(get,set) : Plane;
	public function get_plane() : Plane
	{
		return plane;
	}
	public function set_plane(v : Plane) : Plane
	{
		return plane = v;
	}
	
	public function new(target : Plane, source : Plane) 
	{
		this.target = target;
		this.plane  = source;
		
		_emitter = new Emitter("graphics/portal.png", 32, 32);
		
		_emitter.newType("portal", [0]);
		_emitter.setMotion("portal", 0, 13, .8, 360, 0, 0.0, null, true);
		_emitter.setAlpha("portal", .0, 1.0, Ease.quadIn);
		
		for (i in 0...20) 
		{
			_emitter.emit("portal", 0, 0);
		}
		
		var distance : Int   = Std.int(G.MaxRadius * HXP.random);
		var angle    : Float = 360.0 * HXP.random;
		
		var position : Point = new Point();
		
		HXP.angleXY(position, angle, distance);
		
		super(position.x, position.y, new Graphiclist([_emitter]));
		
		setHitbox(36, 36, 18, 18);
		type = "portal";
	}
	
	override public function update():Void 
	{
		super.update();
		
	 	if (HXP.random < 0.5) 
		{
			_emitter.emit("portal", 0, 0);
		}
	}
}