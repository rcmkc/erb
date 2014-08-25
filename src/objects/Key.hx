package objects;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.tweens.misc.ColorTween;
import com.haxepunk.utils.Ease;
import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.HXP;
import com.haxepunk.Tween.TweenType;
import openfl.geom.Point;
import common.Plane;
import common.Map;

/**
 * ...
 * @author Romko Pidstryhach

 */
class Key extends GameObject
{
	private var _emitter    : Emitter;
	private var _image      : Image;
	private var _colorTween : ColorTween;
	private var _colors     : Array<UInt>;
	private var _colorStep  : Int;
	
	private var _arrow      : NavigationArrow;
	
	private var _picked : Bool;
	
	@:isVar public var plane(get,set) : Plane;
	public function get_plane() : Plane
	{
		return plane;
	}
	public function set_plane(v : Plane) : Plane
	{
		return plane = v;
	}

	public function new(plane : Plane) 
	{
		this.plane = plane;
		
		_emitter = new Emitter("graphics/keys.png", 24, 24);
		
		_emitter.newType("key", [0]);
		_emitter.setMotion("key", 0, 40, .8, 360, 5, 0.0, null, true);
		_emitter.setAlpha("key", .0, 0.15, Ease.quadIn);
		_emitter.setColor("key", 0xFF0000, 0x7AFF77);
		
		_emitter.newType("pick", [0]);
		_emitter.setMotion("pick", 0, 0, .4, 360, 20, 0.0, Ease.cubeOut, false);
		_emitter.setAlpha("pick", 0.8, 0.0, Ease.cubeOut);
		_emitter.setColor("pick", 0xFF0000, 0x7AFF77);
		
		_picked = false;
		
		_image = new Image("graphics/keys.png");
		_image.centerOrigin();
		
		var distance : Int   = Std.int(G.MaxRadius * HXP.random);
		var angle    : Float = 360.0 * HXP.random;
		
		var position : Point = new Point();
		
		HXP.angleXY(position, angle, distance);
		
		super(position.x, position.y, new Graphiclist([_image, _emitter]));
		
		setHitbox(24, 24, 12, 12);
		type = "key";
		
		_colors = createColorGradient(.3, .3, .3, 0, 2, 4);
		_colorStep = 0;
		
		HXP.alarm(0.1, stepColor, TweenType.Looping);
	}
	
	override public function added():Void 
	{
		super.added();
		
		level.add(_arrow = new NavigationArrow(this));
	}
	
	private function stepColor(_)
	{
		_colorStep++;
		
		if (_colorStep > _colors.length - 1) 
		{
			_colorStep = 0;
		}
		
		_image.color = _colors[_colorStep];
	}
	
	public function pick()
	{
		if (!_picked) 
		{
			_image.visible = false;
			
			level.remove(_arrow);
			_arrow = null;
			
			level.shake(15.0);
			
			for (i in 0...32) 
			{
				_emitter.emit("pick", 0, 0);
			}
			
			_picked = true;
			
			Map.updateKeys(plane);
		}
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (_picked && _emitter.particleCount == 0) 
		{
			level.remove(this);
		}
		
	 	if (HXP.random < 0.5 && !_picked) 
		{
			_emitter.emit("key", 0, 0);
		}
	}
	
	private function createColorGradient(	f1     : Float,  f2 : Float,    f3 : Float, 
											ph1    : Float, ph2 : Float,   ph3 : Float, 
											center : Int = 128, width : Int = 127, length : Int = 32) : Array<UInt>
	{
		var colors : Array<UInt> = [];
		
		for (i in 0...length)
		{
			var r : Int = Std.int(Math.sin(f1*i + ph1) * width + center);
			var g : Int = Std.int(Math.sin(f2*i + ph2) * width + center);
			var b : Int = Std.int(Math.sin(f3*i + ph3) * width + center);
			
			colors.push(HXP.getColorRGB(r, g, b));
		}
		
		return colors;
	}
}