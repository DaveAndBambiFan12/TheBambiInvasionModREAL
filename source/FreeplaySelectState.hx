package;

#if desktop
//erm.jfhgj;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import CoolUtil;
import flixel.input.keyboard.FlxKey;

using StringTools;

class FreeplaySelectState extends MusicBeatState
{
    public static var psychEngineVersion:String = '0.5.1'; //This is also used for Discord RPC
    public static var curSelected:Int = 0;

    var menuItems:FlxTypedGroup<FlxSprite>;
    var menuChar = new FlxSprite();
    private var camGame:FlxCamera;
    private var camAchievement:FlxCamera;

    var optionShit:Array<String> = [
        'main',
        'extra'
    ];

    var magenta:FlxSprite;
    var jumpScare:FlxSprite;
    var camFollow:FlxObject;
    var camFollowPos:FlxObject;
    var debugKeys:Array<FlxKey>;

    override function create()
    {
        var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);

        debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

        camGame = new FlxCamera();
        camAchievement = new FlxCamera();
        camAchievement.bgColor.alpha = 0;

        FlxG.cameras.reset(camGame);
        FlxG.cameras.add(camAchievement);
        FlxCamera.defaultCameras = [camGame];

        transIn = FlxTransitionableState.defaultTransIn;
        transOut = FlxTransitionableState.defaultTransOut;

        persistentUpdate = persistentDraw = true;

		    var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBGBlue'));
        bg.scrollFactor.set(yScroll);
        bg.setGraphicSize(Std.int(bg.width * 1.5));
        bg.updateHitbox();
        bg.screenCenter();
        bg.antialiasing = ClientPrefs.globalAntialiasing;
        add(bg);

        camFollow = new FlxObject(0, 0, 1, 1);
        camFollowPos = new FlxObject(0, 0, 1, 1);
        add(camFollow);
        add(camFollowPos);

        magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuBGMagenta'));
        magenta.scrollFactor.set(yScroll);
        magenta.setGraphicSize(Std.int(magenta.width * 1.5));
        magenta.updateHitbox();
        magenta.screenCenter();
        magenta.visible = false;
        magenta.antialiasing = ClientPrefs.globalAntialiasing;
        add(magenta);

        menuItems = new FlxTypedGroup<FlxSprite>();
        add(menuItems);

        var scale:Float = 0.45;

        for (i in 0...optionShit.length)
        {
            var menuItemTween:FlxTween;
            var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
            var menuItem:FlxSprite = new FlxSprite((i * (1053.3 * 0.5))  + offset, 0).loadGraphic(Paths.image('freeplay/' + optionShit[i]));
            menuItem.scale.x = scale;
            menuItem.scale.y = scale;
            menuItem.ID = i;
            menuItem.screenCenter(Y);
            menuItems.add(menuItem);
            menuItem.scrollFactor.set(0.8, 0.8);
            menuItem.antialiasing = ClientPrefs.globalAntialiasing;
            menuItem.setGraphicSize(Std.int(menuItem.width * 0.80));
            menuItem.cameras = [camGame];
            menuItem.updateHitbox();
        }

        FlxG.camera.follow(camFollowPos, null, 1);

        var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
        versionShit.scrollFactor.set();
        versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(versionShit);

        var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
        versionShit.scrollFactor.set();
        versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(versionShit);

        changeItem();

        super.create();
    }

    var selectedSomethin:Bool = false;

    override function update(elapsed:Float)
    {
        if (FlxG.sound.music.volume < 0.8)
        {
            FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
        }

        var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
        camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

        if (!selectedSomethin)
        {
            if (controls.UI_LEFT_P)
            {
                FlxG.sound.play(Paths.sound('scrollMenu'));
                changeItem(-1);
            }

            if (controls.UI_RIGHT_P)
            {
                FlxG.sound.play(Paths.sound('scrollMenu'));
                changeItem(1);
            }

            if (controls.BACK)
            {
                selectedSomethin = true;
                FlxG.sound.play(Paths.sound('cancelMenu'));
                MusicBeatState.switchState(new MainMenuState());
            }

            if (controls.ACCEPT)
            {
              CoolUtil.curFreeplayGroup = curSelected;
              trace('SELECTED THING', CoolUtil.curFreeplayGroup);
              MusicBeatState.switchState(new FreeplayState());
            }
        }

        super.update(elapsed);

    }

    function changeItem(huh:Int = 0)
    {
        curSelected += huh;
        if (curSelected >= menuItems.length)
            curSelected = 0;
        if (curSelected < 0)
            curSelected = menuItems.length - 1;

        menuItems.forEach(function(spr:FlxSprite)
        {
            spr.updateHitbox();
            if (spr.ID == curSelected)
            {
                camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - 250);
                //trace('im gonna kill myself', spr.getGraphicMidpoint().x, curSelected);
                spr.centerOffsets();
            }
        });
    }
}
