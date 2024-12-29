package states;

import dialogue.ShopBox;
import flixel.addons.text.FlxTypeText;

class ShopState extends FlxState
{
    var soul:FlxSprite; // selector

    var curSelected:Int = 0;
    var options:Array<String> = ['Buy', 'Sell', 'Talk', 'Exit'];
    var grpText:FlxTypedGroup<FlxText>;

    var dialogue:FlxTypeText;

    override function create()
    {
        // yeah

        FlxG.sound.playMusic(Paths.music('shopMenu'));

        // background assets

        var bg = new FlxSprite().loadGraphic(Paths.image('placeholder'));
        add(bg);
        
        // options waa

        var dumb = new ShopBox();
        add(dumb);

        dialogue = new FlxTypeText(40, 268, 400, null, 30);
        dialogue.font = Paths.font();
        dialogue.sounds = [FlxG.sound.load(Paths.sound('text_snd_default'))];
        add(dialogue);

        soul = new FlxSprite().loadGraphic(Paths.image('soul'));
        add(soul);

        grpText = new FlxTypedGroup<FlxText>();
        add(grpText);

        for (i in 0...options.length)
        {
            var item = new FlxText(480, 268 + (i*40), 0, options[i], 32);
            item.font = Paths.font();
            item.ID = i;
            grpText.add(item);
        }

        changeItem();
        updateText();
        super.create();
    }

    override function update(elapsed:Float)
    {
        if (FlxG.keys.anyJustPressed([W, UP]))
            changeItem(-1);
        if (FlxG.keys.anyJustPressed([S, DOWN]))
            changeItem(1);

        super.update(elapsed);
    }

    function changeItem(change:Int = 0)
    {
        curSelected = FlxMath.wrap(curSelected + change, 0, options.length-1);

        grpText.forEach(function(txt:FlxText)
        {
            if (txt.ID == curSelected)
            {
                soul.x = txt.x - 30;
                soul.y = txt.y + 10;
            }    
        });

        FlxG.sound.play(Paths.sound('moveMenu'));
    }

    function updateText(text:String = '* But nobody came.')
    {
        dialogue.resetText(text);
        dialogue.start(0.04, true);
    }
}