package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();

		Settings.load();

		addChild(new FlxGame(0, 0, states.ShopState, 60, 60, true, false));
	}
}
