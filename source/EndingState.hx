package;
import flixel.*;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class EndingState extends FlxState
{

	var _ending:Bool = false;
	
	public function new(ending:Bool = true) 
	{
		super();
		_ending = ending;
		
	}
	
	override public function create():Void 
	{
		super.create();
		var end:FlxSprite = new FlxSprite(0, 0);
		if (_ending){
			end.loadGraphic(Paths.image("ron/misc/fard"));
			end.screenCenter(X);
			end.screenCenter(Y);
			FlxG.sound.playMusic(Paths.music("endmusic"),1,false);
		}
		add(end);
		FlxG.camera.fade(FlxColor.BLACK, 0.8, true);
		
		
		new FlxTimer().start(10, endIt);
		
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