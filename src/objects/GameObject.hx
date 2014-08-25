package objects;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import scenes.Level;

/**
 * ...
 * @author Romko Pidstryhach

 */
class GameObject extends Entity
{
	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
		
	}
	
	@:isVar public var level(get, null) : Level;
	public function get_level() : Level
	{
		return level;
	}
	
	override public function added():Void 
	{
		super.added();
		level = cast(world, Level);
	}
}