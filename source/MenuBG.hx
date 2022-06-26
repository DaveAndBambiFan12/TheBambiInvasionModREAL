//maybe useless???? idk
package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxTimer;
import flixel.FlxG;

class MenuBG extends FlxSprite
{
	private var idleAnim:String;
  public var isFlickering:Bool = false;
  var daColor:Int; //for flickering

  private var bgs:Array<FancyMancy> = [ //this is useless (the FancyMancy object) but i wanted to see how it would work and stuff so i could use it somewhere else ig fidjsgjklahsgkhj
    new FancyMancy('expunged clones', false), //image name, antialiasing
    new FancyMancy('choco', false),
    new FancyMancy('amogus', false),
    new FancyMancy('dave', false),
    new FancyMancy('jadi', false)
  ]; //image name, antialiasing
	public function new(x:Float = 0, y:Float = 0, ?color:Int = null) {
		super(x, y);

    if(color != null)
    {
      this.color = color;
      daColor = color;
    }

    trace(bgs.length);

    var daBG:FancyMancy = bgs[FlxG.random.int(0, bgs.length-1)];

    loadGraphic(Paths.image('menubgs/' + daBG.imagePath));
    antialiasing = daBG.antialiasing;
	}


  //only use the first 3 values! the ohter ones are so the thing works :)
  public function flicker(duration:Float, interval:Float, ?newColor:Int, ?orig:Bool = false, first:Bool = true)
  {
    if(first)
      isFlickering = true;

    if(isFlickering)
    {
      color = orig ? daColor : newColor;
      new FlxTimer().start(interval, function(tmr:FlxTimer) //loops basically
      {
        flicker(duration, interval, newColor, !orig, false);
      });
      if(first && duration > 0)
      {
        new FlxTimer().start(duration, function(tmr:FlxTimer)
        {
          isFlickering = false;
          color = daColor;
        });
      }
    }
  }
}
class FancyMancy //not nessesary(shut up) but wanted to do it cause i wanted to lol
{
  public var imagePath:String;
  public var antialiasing:Bool;

  public function new(imagePath:String, antialiasing:Bool = null)
  {
    this.imagePath = imagePath;
    if(antialiasing != null)
      this.antialiasing = antialiasing;
    else
      this.antialiasing = ClientPrefs.globalAntialiasing;
  }
}
