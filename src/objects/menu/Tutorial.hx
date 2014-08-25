package objects.menu;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Text;
import com.haxepunk.Mask;
import common.GroupEntity;

/**
 * ...
 * @author Romko Pidstryhach

 */
class Tutorial extends GroupEntity
{

	public function new() 
	{
		var tutorial : Text = new Text("", 0, 0, 0, 0, {size : 32});
		tutorial.font  = "font/Pixie.ttf";
		tutorial.text  = "Use your arrows";
		tutorial.alpha = 0.5;
		tutorial.centerOrigin();
		
		super(320, 240, tutorial);
	}
	
}