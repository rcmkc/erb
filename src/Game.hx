import com.haxepunk.Engine;
import com.haxepunk.HXP;
import scenes.Level;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import common.Map;

class Game extends Engine
{

	override public function init()
	{
		defineInputs();
		
		HXP.defaultFont = "font/xenobear.ttf";
		
#if debug
		HXP.console.enable();
#end
		
		Map.createPlanes();
		
		Audio.init();
		Audio.loopTheme();
		
		HXP.scene = new Level(Map.graph[0]);
	}

	public static function main() { new Game(); }
	
	private function defineInputs()
	{
		Input.define("up", [Key.UP]);
		Input.define("down", [Key.DOWN]);
		Input.define("left", [Key.LEFT]);
		Input.define("right", [Key.RIGHT]);
		
		Input.define("fire", [Key.SPACE]);
	}

}