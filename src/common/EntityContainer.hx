package common;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
/**
 * ...
 * @author Romko Pidstryhach

 */
class EntityContainer extends Entity
{
	private var _list : Array<GroupEntity>;
	
	public function new() 
	{
		super();
		
		_list = [];
	}
	
	override public function update():Void 
	{
		updateGroup();
	}
	
	public function addEntity(e : GroupEntity)
	{
		_list.push(e);
	}
	
	override public function added():Void 
	{
		super.added();
		
		for (i in _list) 
		{
			world.add(i);
		}
	}
	
	override public function removed():Void 
	{
		for (i in _list) 
		{
			world.remove(i);
		}
		
		super.removed();
	}
	
	public function updateGroup()
	{
		for (i in _list) 
		{
			i.alpha = alpha;
			i.posX = x;
			i.posY = y;
		}
	}
	
	@:isVar public var alpha(get, set) : Float = 1.0;
	public function get_alpha() : Float
	{
		return alpha;
	}
	
	public function set_alpha(v : Float) : Float
	{
		return alpha = v;
	}
}