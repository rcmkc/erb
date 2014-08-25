package ;
import com.haxepunk.Sfx;

/**
 * ...
 * @author Romko Pidstryhach

 */
class Audio
{
	private static var _theme : Sfx;
	private static var _drone : Sfx;
	private static var _exit : Sfx;
	
	public static function init()
	{
		_theme = new Sfx("audio/theme.mp3");
		_drone = new Sfx("audio/drone.mp3");
		_exit = new Sfx("audio/exit.mp3");
	}
	
	public static function loopTheme()
	{
		_theme.loop(0.7);
	}
	
	public static function loopDrone()
	{
		_drone.loop(1.0);
	}
	
	public static function playExit()
	{
		_exit.play(1.0);
	}
	
	public static function setDroneVolume(v : Float)
	{
		_drone.volume = v;
	}
}