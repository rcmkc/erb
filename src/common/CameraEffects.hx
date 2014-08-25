package common;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import openfl.geom.Rectangle;
import objects.Player;
/**
 * ...
 * @author Romko Pidstryhach

 */
class CameraEffects
{
	private var _shakingIntensity : Float;
	private var _isShaking        : Bool;
	private var _bounds           : Rectangle;
	private var _entityToFollow   : Player;
	private var _maxFollowOffset  : Float;
	private var _followRate       : Float;
	private var _entityX          : Float;
	private var _entityY          : Float;
	
	public function new ()
	{
		_shakingIntensity = 0.0;
		_isShaking = false;
	}
	
	public function setBounds(rect : Rectangle)
	{
		_bounds = rect;
	}
	
	public function follow(entity : Player, maxOffset : Float, rate : Float)
	{
		_entityToFollow  = entity;
		_maxFollowOffset = maxOffset;
		_followRate      = rate;
		
		HXP.camera.x = entity.x - HXP.width * 0.5;
		HXP.camera.y = entity.y - HXP.height * 0.5;
	}
	
	public function startShake(intensity : Float = 25.0) : Void
	{
		stopShake();
		this._shakingIntensity = intensity;
	}
		
	public function stopShake():Void
	{
		_shakingIntensity  = 0.0;
		_isShaking = false;
	}
	
	public function update()
	{
		if (_entityToFollow != null) 
		{
			_entityX = _entityToFollow.x - HXP.width * 0.5 ;
			_entityY = _entityToFollow.y - HXP.height * 0.5 ;
			
			HXP.point.x = HXP.camera.x - _entityX;
			HXP.point.y = HXP.camera.y - _entityY;
			
			var distance : Float = HXP.point.length;
			
			if (distance > _maxFollowOffset)
			{
				distance = _maxFollowOffset;
			}
			
			HXP.point.normalize(distance * _followRate);
			
			HXP.camera.x = _entityX + HXP.point.x;// + _entityToFollow.speed.x / 100;
			HXP.camera.y = _entityY + HXP.point.y;// + _entityToFollow.speed.y / 100;
		}
		else
		{
			_entityX = HXP.camera.x;
			_entityY = HXP.camera.y;
		}
		
		if (_shakingIntensity > 0.0)
		{
			_shakingIntensity--;
			_isShaking = true;
			
			if (_shakingIntensity <= 0.0)
			{
				stopShake();
			}
			else
			{
				//TODO fix this
				HXP.camera.x = _entityX + HXP.point.x + HXP.random * _shakingIntensity - _shakingIntensity * 0.5;
				HXP.camera.y = _entityY + HXP.point.y + HXP.random * _shakingIntensity - _shakingIntensity * 0.5;
			}
		}
		
		/*if (_bounds != null) 
		{
			HXP.camera.x = HXP.clamp(HXP.camera.x, _bounds.x, _bounds.x + _bounds.width  - HXP.width);
			HXP.camera.y = HXP.clamp(HXP.camera.y, _bounds.y, _bounds.y + _bounds.height - HXP.height); 
		}*/
	}
}