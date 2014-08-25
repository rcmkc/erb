package objects;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.Mask;
import com.haxepunk.utils.Ease;

/**
 * ...
 * @author Romko Pidstryhach

 */
class ParticleEffects extends Entity
{
	private static var _emitter : Emitter;
	
	public function new() 
	{
		_emitter = new Emitter("graphics/portal.png", 32, 32);
		_emitter.newType("exit", [0]);
		_emitter.setAlpha("exit", 0.2, 0.0, Ease.expoOut);
		
		super(0, 0, _emitter);
	}
	
	public static function emitExit(x : Float, y : Float, angle : Float) : Void
	{
		_emitter.setMotion("exit", angle - 10, 0, 1.0, 20, 150, 1.0, Ease.expoOut, false);
		
		for (i in 0...50) 
		{
			_emitter.emit("exit", x, y);
		}
	}
}