package;

import flixel.input.gamepad.FlxGamepad;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;


#if windows
import Discord.DiscordClient;
#end

using StringTools;

class CreditsState extends MusicBeatState
{
	var songs:Array<Modders> = [];

	var selector:FlxText;
	var curSelected:Int = 0;

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;

	private var iconArray:Array<HealthIcon> = [];

	override function create()
	{
		var initSonglist = CoolUtil.coolTextFile(Paths.txt('creditsPersons'));

		for (i in 0...initSonglist.length)
		{
			var data:Array<String> = initSonglist[i].split(':');
			songs.push(new Modders(data[0], data[1]));
		}

        FlxG.sound.playMusic(Paths.music('freakyMenu'));

		 #if windows
		 // Updating Discord Rich Presence
		 DiscordClient.changePresence("In the Credits Menu", null);
		 #end

		var isDebug:Bool = false;

		#if debug
		isDebug = true;
		#end

		// LOAD MUSIC

		// LOAD CHARACTERS

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBGBlue'));
		add(bg);

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		for (i in 0...songs.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songs[i].songName, true, false, true);
			songText.isMenuItem = true;
			songText.targetY = i;
			grpSongs.add(songText);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}

		changeSelection();

		// FlxG.sound.playMusic(Paths.music('title'), 0);
		// FlxG.sound.music.fadeIn(2, 0, 0.8);
		selector = new FlxText();

		selector.size = 40;
		selector.text = ">";
		// add(selector);

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		// JUST DOIN THIS SHIT FOR TESTING!!!
		/* 
			var md:String = Markdown.markdownToHtml(Assets.getText('CHANGELOG.md'));

			var texFel:TextField = new TextField();
			texFel.width = FlxG.width;
			texFel.height = FlxG.height;
			// texFel.
			texFel.htmlText = md;

			FlxG.stage.addChild(texFel);

			// scoreText.textField.htmlText = md;

			trace(md);
		 */

		super.create();
	}

	public function addSong(songName:String, songCharacter:String)
	{
		songs.push(new Modders(songName, songCharacter));
	}

	public function addWeek(songs:Array<String>, ?songCharacters:Array<String>)
	{
		if (songCharacters == null)
			songCharacters = ['dad'];

		var num:Int = 0;
		for (song in songs)
		{
			addSong(song, songCharacters[num]);

			if (songCharacters.length != 1)
				num++;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var upP = FlxG.keys.justPressed.UP;
		var downP = FlxG.keys.justPressed.DOWN;
		var accepted = controls.ACCEPT;

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (gamepad != null)
		{
			if (gamepad.justPressed.DPAD_UP)
			{
				changeSelection(-1);
			}
			if (gamepad.justPressed.DPAD_DOWN)
			{
				changeSelection(1);
			}
		}

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (controls.BACK)
		{
			FlxG.switchState(new MainMenuState());
		}

		if (accepted)
		{
            switch(curSelected)
            {
                case 0:
                    FlxG.openURL("https://gamebanana.com/members/1846650");
                case 1:
                    FlxG.openURL("https://gamebanana.com/members/1782968");
				case 2:
					FlxG.openURL("https://gamebanana.com/members/1714082");
				case 3:
					FlxG.openURL("https://clips.twitch.tv/CuriousBrainyFriseePogChamp-3GIEA2MKSohYB8VW");
				case 4:
					FlxG.openURL("https://gamebanana.com/members/1797091");
				case 5:
					FlxG.openURL("https://gamebanana.com/members/1878606");
				case 6:
					FlxG.openURL("https://gamejolt.com/@Ekical");
				case 7:
					FlxG.openURL("https://gamebanana.com/members/1966530");
				case 8:
					FlxG.openURL("https://www.youtube.com/channel/UC-jtjO3youJyDbpH67uDn_g");
				case 9:
					FlxG.openURL("https://gamebanana.com/members/1795346");
				case 10:
					FlxG.openURL("https://gamebanana.com/members/1864849");
				case 11:
					FlxG.openURL("https://gamejolt.com/@firey7k");
				case 12:
					FlxG.openURL("https://gamebanana.com/members/1916432");
				case 13:
					FlxG.openURL("https://www.youtube.com/channel/UCLATrFLIwMFqvWLDKJ3GXjw");
				case 14:
					FlxG.openURL("https://gamebanana.com/members/1800032");
				case 15:
					FlxG.openURL("https://gamebanana.com/members/1663640");
				case 16:
					FlxG.openURL("https://gamebanana.com/members/1934701");
				case 17:
					FlxG.openURL("https://gamebanana.com/members/1775077");
				case 18:
					FlxG.openURL("https://gamebanana.com/members/1774971");
				case 19:
					FlxG.openURL("https://gamebanana.com/members/1805202");
            }
		}
	}

	function changeSelection(change:Int = 0)
	{
		#if !switch
		// NGio.logEvent('Fresh');
		#end

		// NGio.logEvent('Fresh');
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;
		
		// adjusting the highscore song name to be compatible (changeSelection)
		// would read original scores if we didn't change packages

		var bullShit:Int = 0;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}

class Modders
{
	public var songName:String = "";
	public var songCharacter:String = "";

	public function new(song:String, songCharacter:String)
	{
		this.songName = song;
		this.songCharacter = songCharacter;
	}
}
