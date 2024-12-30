package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();

		Settings.load();
		Controls.load();

		addChild(new FlxGame(0, 0, states.TitleState, 60, 60, false, false));
	}
}
