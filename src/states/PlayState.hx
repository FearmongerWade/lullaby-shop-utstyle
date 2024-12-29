package states;

import dialogue.DialogueBox;

class PlayState extends FlxState
{
	var test:DialogueBox;
	var stilltest:String = 'hi there would you like to sign my petition?';

	override function create()
	{
		FlxG.camera.bgColor = 0xFF868686;

		test = new DialogueBox(stilltest);
		add(test);
		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.ENTER)
			test.startDialogue(stilltest);

		super.update(elapsed);
	}
}
