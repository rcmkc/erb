package objects;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import openfl.display.BitmapData;
import com.haxepunk.graphics.Spritemap;
import openfl.display.BlendMode;
import com.haxepunk.HXP;

/**
 * ...
 * @author Romko Pidstryhach

 */
class Overlay extends Entity
{

	public function new() 
	{
		var noise : BitmapData = new BitmapData(HXP.width * 2, HXP.height * 4, true, 0x000000);
		noise.noise(HXP.rand(666), 0, 7, 7, false);
		
		var noiseAnim : Spritemap = new Spritemap(noise, 320, 240);
		noiseAnim.blend = BlendMode.ADD;
		noiseAnim.add("noise", [0, 1, 2, 3, 4, 5, 6, 7], 40, true);
		noiseAnim.play("noise");
		noiseAnim.scale = 2;
		
		super(0, 0, noiseAnim);	
		
		graphic.scrollX = 0.0;
		graphic.scrollY = 0.0;
	}
}