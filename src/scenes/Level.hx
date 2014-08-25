package scenes;

import com.haxepunk.Scene;
import common.CameraEffects;
import common.Plane;
import objects.enemies.Chaser;
import objects.Enemy;
import objects.Flock;
import objects.Key;
import objects.menu.MainMenu;
import objects.NavigationArrow;
import objects.Overlay;
import objects.ParticleEffects;
import objects.Player;
import objects.Portal;
import com.haxepunk.HXP;
import com.haxepunk.math.Vector;

/**
 * ...
 * @author Romko Pidstryhach

 */
class Level extends Scene
{
	private var _player  : Player;
	private var _camera  : CameraEffects;
	private var _portals : Array<Vector>;
	
	private var _flock   : Flock;
	
	public function new(plane : Plane, from : Plane = null) 
	{
		super();
		
		HXP.randomSeed = plane.seed;
		
		if (plane.key) 
		{
			add(new Key(plane));
		}
		
		if (from == null) 
		{
			add(_player = create(Player, true, [320, 240, false]));
			add(new MainMenu());
		}
		
		for (i in plane.getPath()) 
		{
			var portal : Portal = add(new Portal(i, plane));
			
			add(new NavigationArrow(portal));
			
			if (from != null) 
			{
				if (portal.target.seed == from.seed) 
				{
					add(_player = create(Player, true, [portal.x, portal.y]));
				}
			}
		}
		
		//Audio.loopDrone();
		
		//create(Overlay);
		add(new ParticleEffects());
		
		_flock = new Flock();
		_flock.setTarget(_player);
		
		for (j in 0...HXP.rand(25)) 
		{
			_flock.addAgent(add(new Chaser(_player)));
		}
	}
	
	override public function update() 
	{

		super.update();
		_flock.update();
		_camera.update();
	}
	
	public function shake(amount : Float)
	{
		_camera.startShake(amount);
	}
	
	override public function begin() 
	{
		super.begin();
		
		_camera = new CameraEffects();
		//_camera.setBounds(G.Bounds);
		_camera.follow(_player, 150.0, 0.95);
	}
}