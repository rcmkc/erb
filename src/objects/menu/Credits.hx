package objects.menu;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Text;
import com.haxepunk.Mask;
import common.GroupEntity;

/**
 * ...
 * @author Romko Pidstryhach

 */
class Credits extends GroupEntity
{
	public function new() 
	{
		var credits : Text = new Text("");
		credits.font  = "font/Pixie.ttf";
		credits.text  = "© by xenobear";
		credits.alpha = 0.5;
		credits.centerOrigin();
		
		super(380, 160, credits);	
	}
}