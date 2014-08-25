package objects;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;
import com.haxepunk.math.Vector;
import com.haxepunk.utils.Input;
import com.haxepunk.HXP;
import scenes.Level;
import common.Map;

/**
 * ...
 * @author Romko Pidstryhach
 */
 
class Player extends GameObject
{
	private var _image      : Image;
	private var _teleported : Bool;
	
	private var _initX : Float;
	private var _initY : Float;
	
	private var _isDead : Bool;
	
	@:isVar public var invisible(get, set) : Bool;
	public function get_invisible() : Bool
	{
		return invisible;
	}
	public function set_invisible(b : Bool) : Bool
	{
		return invisible = b;
	}
	
	@:isVar public var speed(get, null) : Vector;
	public function get_speed() : Vector
	{
		return speed;
	}
	
	public function new(x : Float, y : Float, teleported : Bool = true) 
	{
		_image = Image.createCircle(5, 0xD9FFE9);
		_image.centerOrigin();
		
		speed = new Vector();
		
		_teleported = teleported;
		_isDead = false;
		
		super(x, y, _image);
		
		setHitbox(5, 5, 3, 3);
		
		_initX = x;
		_initY = y;
	}
	
	override public function update():Void 
	{
		super.update();
		
		var velocity : Float = HXP.scaleClamp(speed.length, 0, G.MaxSpeed, 0.0, 1.0);
		
		_image.scaleX = 1 + velocity;
		_image.angle = HXP.angle(0, 0, speed.x, speed.y);
		_image.alpha = velocity;
		
		if (velocity < 0.3) 
		{
			invisible = true;
		}
		else
		{
			invisible = false;
		}
		
		updateMovement();
		//updateShooting();
		updateCollisions();
	}
	
	private function fireBullet(angle : Float)
	{
		cast(level.create(Bullet), Bullet).spawn(x, y, angle, G.BulletSpeed);
	}
	
	private function updateCollisions()
	{
		var portal : Portal = cast(collide("portal", x, y), Portal);
		
		if (portal != null && !_teleported) 
		{
			world.recycle(this);
			HXP.world = new Level(portal.target, portal.plane);
			_teleported = true;
		}
		else if (portal == null)
		{
			if (_teleported) 
			{
				ParticleEffects.emitExit(_initX, _initY, HXP.angle(0, 0, speed.x, speed.y));
				level.shake(25.0);
				_teleported = false;
				Audio.playExit();
			}
		}
		
		var key : Key = cast(collide("key", x, y), Key);
		
		if (key != null) 
		{
			key.pick();
		}
		
		if (collide("enemy", x, y) != null && !invisible) 
		{
			level.shake(50.0);
			_image.visible = false;
			HXP.alarm(1.0, newGame);
			Audio.playExit();
		}
	}
	
	private function newGame(_)
	{
		HXP.world = new Level(Map.graph[0]);
	}
	
	private function updateMovement():Void 
	{
		if (Input.check("right")) 
		{
			if (speed.x < G.MaxSpeed)
			{
				speed.x += G.Acceleration;
			}
		}
		else if (Input.check("left")) 
		{
			if (speed.x > - G.MaxSpeed)
			{
				speed.x -= G.Acceleration;
			}
		}
		else
		{
			speed.x *= G.Friction;
		}
		
		if (Input.check("up")) 
		{
			if (speed.y > - G.MaxSpeed)
			{
				speed.y -= G.Acceleration;
			}
		}
		else if (Input.check("down")) 
		{
			if (speed.y < G.MaxSpeed)
			{
				speed.y += G.Acceleration;
			}
		}
		else 
		{
			speed.y *= G.Friction;
		}
		
		if (!_isDead) 
		{
			moveBy(speed.x * HXP.elapsed, speed.y * HXP.elapsed);	
		}
	}
}