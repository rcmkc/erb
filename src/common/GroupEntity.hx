package common;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import com.haxepunk.HXP;

/**
 * ...
 * @author Romko Pidstryhach

 */
class GroupEntity extends Entity
{
	private var offsetX : Float;
	private var offsetY : Float;
	
	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
		
		offsetX = x;
		offsetY = y;
	}
	
	@:isVar public var posX(get, set) : Float;
	private inline function get_posX() : Float
	{
		return posX;
	}
	private inline function set_posX(v : Float) : Float
	{
		return x = v + offsetX;
	}
	
	@:isVar public var posY(get, set) : Float;
	private inline function get_posY() : Float
	{
		return posY;
	}
	private inline function set_posY(v : Float) : Float
	{
		return y = v + offsetY;
	}
	
	@:isVar public var alpha(get, set) : Float;
	public function get_alpha() : Float
	{
		var alphaValue = Reflect.getProperty(graphic, "alpha");
		
		return Std.is(alphaValue, Float) ? alphaValue : 1.0;
	}
	
	public function set_alpha(v : Float) : Float
	{
		var alphaValue = Reflect.getProperty(graphic, "alpha");
		
		alphaValue = HXP.scaleClamp(v, 0.0, 1.0, 0.0, alphaValue);
		
		Reflect.setProperty(graphic, "alpha", alphaValue);
		
		return Std.is(alphaValue, Float) ? alphaValue : 1.0;
	}
	
	
}