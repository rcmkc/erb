package common;
import com.haxepunk.HXP;
/**
 * ...
 * @author Romko Pidstryhach

 */
class Map
{
	public static var planes : Array<Plane>;
	public static var graph  : Array<Plane>;
	
	private static var keys : Array<Bool>;
	
	public static function createPlanes()
	{
		planes = [];
		
		for (i in 0...G.PlanesNumber) 
		{
			planes.push(new Plane());
		}	
		
		generateMap();
		
		keys = [];
		
		for (j in 0...G.KeyNumber) 
		{
			keys.push(true);
		}
		
		spawnKeys();
		/*for (j in graph) 
		{
			trace("plane " + j.seed);
			
			for (k in j.getPath()) 
			{
				trace("    targets " + k.seed );
			}	
		}*/
	}
	
	private static function spawnKeys()
	{
		while (keys.length > 0) 
		{
			var keyNode : Plane = graph[HXP.rand(graph.length - 1)];
			
			if (keyNode.key == false) 
			{
				keyNode.key = keys.pop();
			}
		}
	}
	
	public static function updateKeys(plane : Plane)
	{
		for (i in graph) 
		{
			if (i.seed == plane.seed) 
			{
				i.key = false;
			}
		}
	}
	
	private static function generateMap()
	{
		graph = [];
		
		HXP.shuffle(planes);
		
		var currentNode : Plane = planes.pop();
		var randomNode  : Plane;
		
		graph.push(currentNode);
		
		while (planes.length > 0) 
		{
			randomNode = planes[planes.length - 1];
			
			if (randomNode.pathCount() < 1) 
			{
				currentNode.addPath(randomNode);
				randomNode.addPath(currentNode);
				graph.push(planes.pop());
			}
			
			currentNode = randomNode;
		}
	}
}