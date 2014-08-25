package objects.menu;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.Mask;
import common.GroupEntity;

/**
 * ...
 * @author Romko Pidstryhach

 */
class Logo extends GroupEntity
{
	public function new() 
	{
		var logo : Text = new Text("ERB", 0, 0, 0, 0, { size : 96 } );
		logo.centerOrigin();
		
		super(326, 120, logo);
		
		layer = -10;
	}
}