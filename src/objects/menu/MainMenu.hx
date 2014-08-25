package objects.menu;
import common.EntityContainer;
import com.haxepunk.HXP;
/**
 * ...
 * @author Romko Pidstryhach

 */
class MainMenu extends EntityContainer
{

	public function new() 
	{
		super();
		
		addEntity(new Logo());
		addEntity(new Credits());
		addEntity(new Tutorial());
	}
	
	override public function update():Void 
	{
		super.update();
		
		var distance : Float = HXP.distance(HXP.camera.x, HXP.camera.y, x, y);
		
		alpha = HXP.scaleClamp(distance, 0.0, 200.0, 1.0, 0.0);
		
		if (alpha <= 0.0) 
		{
			world.remove(this);
		}
	}
}