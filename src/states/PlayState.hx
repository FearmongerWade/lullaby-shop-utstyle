package states;

import flixel.addons.text.FlxTypeText;

class PlayState extends FlxState
{
	var guy:FlxSprite;
	var prefix:FlxText;

	var curText:Int = 0;
	var dialogue:FlxTypeText;

	var curSelected:Int = 0;
	var options:Array<String> = ['Yes', 'No'];
	var group:FlxTypedGroup<FlxText>;

	override function create()
	{
		if (FlxG.sound.music.playing)
			FlxG.sound.music.stop();

		// banbuds is cartridge guy single?
		guy = new FlxSprite(0, 40).loadGraphic(Paths.image('fake_battle/him'), true, 256, 256);
		guy.animation.add('side', [0], 1, false);
		guy.animation.add('front', [1], 1, false);
		guy.animation.play('side');
		guy.screenCenter(X);
		add(guy); 

		// dialogue shit
		var white = new FlxSprite(0, 320).makeGraphic(575, 150, FlxColor.WHITE);
        white.screenCenter(X);
        add(white);

        var black = new FlxSprite(white.x+5, white.y+5).makeGraphic(565, 140, FlxColor.BLACK);
        add(black);

        prefix = new FlxText(black.x+10, black.y+10, 0, '*', 30);
        prefix.font = Paths.font('PixelOperator-Bold.ttf');
        add(prefix);

        dialogue = new FlxTypeText(prefix.x + prefix.width + 20, prefix.y, Std.int(white.width * 0.7), 'Hello human', 30);
        dialogue.font = Paths.font('PixelOperator-Bold.ttf');
        dialogue.sounds = [FlxG.sound.load(Paths.sound('textbox/cartridgeGuy'))];
        add(dialogue);

		// choice shit

		group = new FlxTypedGroup<FlxText>();
		add(group);

		for (i in 0...options.length)
		{
			var item = new FlxText(100+(i*360), 380, 0, options[i], 34);
			item.font = Paths.font();
			item.ID = i;
			item.alpha = 0;
			group.add(item);
		}

		doShit();
		super.create();
	}

	// tw:// bad coding
	var choosing:Bool = false;
	var selectedShop:Bool = false;
	override function update(elapsed:Float)
	{
		if (Controls.justPressed('confirm'))
		{
			if (curText <= 3)
				curText ++;
			
			doShit();
		}

		if (Controls.justPressed('menuLeft'))
			changeItem(-1);
		if (Controls.justPressed('menuRight'))
			changeItem(1);

		super.update(elapsed);
	}
	
	function doShit()
	{
		switch (curText)
		{
			case 0:
				dialogue.resetText('Hello human');
				dialogue.start(0.04, true);
			case 1:
				guy.animation.play('front');
				dialogue.resetText('Would you like a free video game?');
				dialogue.start(0.04, true);
			case 2:
				if (!choosing)
					choosing = true;

				changeItem();
			case 3:
				selectItem();
			case 4:
				if (selectedShop)
					openSubState(new substates.TransOut());
				else
				{
					dialogue.resetText('Till we meet again.');
					dialogue.start(0.04, true);
				}
		}
	}

	function changeItem(change:Int = 0)
	{
		if (choosing)
		{
			curSelected = FlxMath.wrap(curSelected + change, 0, options.length - 1);

			dialogue.alpha = 0;
			prefix.alpha = 0;

			group.forEach(function(txt:FlxText)
			{
				txt.alpha = 1;
				txt.color = FlxColor.WHITE;
	
				if (txt.ID == curSelected)
					txt.color = 0xffffff00;
			});
	
			FlxG.sound.play(Paths.sound('moveMenu'));
		}
	}

	function selectItem()
	{
		if (choosing)
		{
			choosing = false;
			curText ++;

			dialogue.alpha = 1;
			prefix.alpha = 1;

			group.forEach(function(txt:FlxText) { txt.alpha = 0; });

			FlxG.sound.play(Paths.sound('menuSelect'));

			switch (options[curSelected])
			{
				case 'Yes':
					dialogue.resetText('Excellent. Follow me.');
					dialogue.start(0.04, true);
					selectedShop = true;
				case 'No':
					guy.animation.play('side');
					dialogue.resetText('Whatever you say, pal.');
					dialogue.start(0.04, true);
			}
		}
	}
}
