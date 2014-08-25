package common;

import com.haxepunk.HXP;
/**
 * ...
 * @author Romko Pidstryhach

 */
class Plane
{
	@:isVar public var seed(get,set) : UInt;
	public function get_seed() : UInt
	{
		return seed;
	}
	public function set_seed(v : UInt) : UInt
	{
		return seed = v;
	}
	
	@:isVar public var key(get,set) : Bool;
	public function get_key() : Bool
	{
		return key;
	}
	public function set_key(v : Bool) : Bool
	{
		return key = v;
	}
	
	private var _edges : Array <Plane>;
	
	public function new() 
	{
		seed = Std.int(HXP.random * 0xFFFFFF);
		key  = false;
		
		_edges = [];
	}
	
	public function addPath(v : Plane)
	{
		_edges.push(v);
	}
	
	public function getPath() : Array<Plane>
	{
		return _edges;
	}
	
	public function pathCount() : Int
	{
		return _edges.length;
	}
}