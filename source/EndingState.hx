package;
import flixel.*;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class EndingState extends FlxState
{

	var _goodEnding:Bool = false;
	
	public function new(goodEnding:Bool = true) 
	{
		super();
		_goodEnding = goodEnding;
		
	}
	
	override public function create():Void 
	{
		super.create();
		var end:FlxSprite = new FlxSprite(0, 0);
		if (_goodEnding)
            {
			end.loadGraphic(Paths.image("ron/fard"));
			end.screenCenter(X);
			end.screenCenter(Y);
			FlxG.sound.playMusic(Paths.music("endmusic"),1,false);
		}
        else
        {
			// need this or it wont work also changed ending thingy AAAAAAAAAAAAAAAAAAAAAAAAAAAAA
            // i've been testing this for like 30 minutes now and it doesn't wanna swtich what
			end.loadGraphic(Paths.image("ron/fard"));
			end.screenCenter(X);
			end.screenCenter(Y);
			FlxG.sound.playMusic(Paths.music("endmusic"),1,false);
		}
		add(end);
		FlxG.camera.fade(FlxColor.BLACK, 0.8, true);
		
		
		new FlxTimer().start(30, endIt);

		trace("it went to the stage at least i think");
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (FlxG.keys.pressed.ENTER){
			endIt();
		}
		
	}
	
	
	public function endIt(e:FlxTimer=null){
        trace("ME WHEN THE uhh IS THE END *aflac the end starts playing*");
		FlxG.switchState(new StoryMenuState());
	}
	
}