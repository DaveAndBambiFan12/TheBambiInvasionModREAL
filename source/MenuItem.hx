package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.util.FlxColor;

class MenuItem extends FlxSprite
{
	public var targetY:Float = 0;
	public var flashingInt:Int = 0;

	var ofsX = 33;

	var ofsY = -30;

	public function new(x:Float, y:Float, weekName:String = '')
	{
		super(x, y);
		loadGraphic(Paths.image('storymenu/' + weekName));
		//trace('Test added: ' + WeekData.getWeekNumber(weekNum) + ' (' + weekNum + ')');
		antialiasing = ClientPrefs.globalAntialiasing;
	}

	private var isFlashing:Bool = false;

	public function startFlashing():Void
	{
		isFlashing = true;
	}

	// if it runs at 60fps, fake framerate will be 6
	// if it runs at 144 fps, fake framerate will be like 14, and will update the graphic every 0.016666 * 3 seconds still???
	// so it runs basically every so many seconds, not dependant on framerate??
	// I'm still learning how math works thanks whoever is reading this lol
	var fakeFramerate:Int = Math.round((1 / FlxG.elapsed) / 10);

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		/*
		DEBUG STUFF
		if(FlxG.keys.pressed.G)
			ofsY -= 1;
		else if(FlxG.keys.pressed.B)
			ofsY += 1;

		if(FlxG.keys.pressed.V)
			ofsX -= 1;
		else if(FlxG.keys.pressed.N)
			ofsX += 1;

		if(FlxG.keys.pressed.H)
			trace(ofsX, ofsY);

		*/



		var scaledY = FlxMath.remapToRange(targetY, 0, 1, 0, 1.3);
		y = (FlxMath.lerp(y, (scaledY * 90) + (FlxG.height * 0.45), 0.16 / (openfl.Lib.application.window.frameRate / 60))) - ofsY;

		x = (FlxMath.lerp(x, Math.exp(Math.abs(scaledY * 0.8)) * -70 + (FlxG.width * 0.35), 0.16 / (openfl.Lib.application.window.frameRate / 60))) + ofsX;

		if (x < -900 + ofsX)
			x = -900 + ofsX;

		if (isFlashing)
			flashingInt += 1;

		if (flashingInt % fakeFramerate >= Math.floor(fakeFramerate / 2))
			color = 0xFF33ffff;
		else
			color = FlxColor.WHITE;
	}
}
